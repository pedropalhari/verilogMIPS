let fileName = process.argv[2];
processFile(fileName);

//Contador de usagem de registro
let registerUsageBank = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

//Lê linha por linha
function processFile(inputFile) {
  var fs = require("fs"),
    readline = require("readline"),
    instream = fs.createReadStream(inputFile),
    outstream = new (require("stream"))(),
    rl = readline.createInterface(instream, outstream);

  var i = 0;
  let instructions = [];
  rl.on("line", function(line = "") {
    //Se é new line sozinho
    if (isNaN(line.charCodeAt(0))) return;

    //console.log(registerUsageBank);
    console.log(parseInstruction(line));
    //console.log(registerUsageBank);
    //console.log();
  });

  rl.on("close", function(line) {
    console.log("Assembling feito!");
  });
}

//Vê se a instrução é padrão aritmético ou movimentação de memória
function parseInstruction(line = "") {
  //A cada linha a quantidade de NOPs para encher o pipeline do registro é decrementada de 1
  decreaseRegisterUsageBank();

  if (
    line.indexOf("add") != -1 ||
    line.indexOf("sub") != -1 ||
    line.indexOf("and") != -1 ||
    line.indexOf("nop") != -1 ||
    line.indexOf("or") != -1
  )
    return parseArithmetic(line);
  else if (line.indexOf("lw") != -1 || line.indexOf("sw") != -1)
    return parseDataMoving(line);
}

function parseArithmetic(line = "") {
  //Array de cada parte da instrução separada
  let orderedLineArray = [];
  //Seu equivalente em bits
  let orderedLineArrayInstruction = [];

  if (line.indexOf("add") != -1) orderedLineArray.push("add");
  else if (line.indexOf("sub") != -1) orderedLineArray.push("sub");
  else if (line.indexOf("and") != -1) orderedLineArray.push("and");
  else if (line.indexOf("or") != -1) orderedLineArray.push("or");
  else if (line.indexOf("nop") != -1) {
    return "00101000000000010001001010011111 //NOP";
  }

  //Deixa só os registradores
  let cutLineAt = line.indexOf("$");
  let cutLine = "";
  cutLine = line.substring(cutLineAt);

  //Pega os registradores em ordem
  orderedLineArray = orderedLineArray.concat(cutLine.split(","));

  //Sanitiza
  orderedLineArray = orderedLineArray.map(string => {
    while (string.indexOf(" ") != -1) string = string.replace(" ", "");
    return string;
  });

  //Checagem para geração de NOPs
  let higherRegisterUsage = 0;
  for (let i = 1; i < 4; i++) {
    let registerNumber = registerStringToNumber(orderedLineArray[i]);

    if (higherRegisterUsage < registerUsageBank[registerNumber])
      higherRegisterUsage = registerUsageBank[registerNumber];
  }

  //Geração de NOPs
  for (let j = 0; j < higherRegisterUsage; j++) {
    console.log(parseInstruction("nop"));
  }

  //Padrão de instrução aritmética
  orderedLineArrayInstruction.push("001010");
  for (let i = 1; i < 4; i++) {
    //Pega o número do registrador pra adicionar na instrução E atualizar a contagem
    let registerNumber = registerStringToNumber(orderedLineArray[i]);

    //Supondo 3 NOPs (4 instruções no pipeline)
    registerUsageBank[registerNumber] = 4;

    orderedLineArrayInstruction.push(
      registerNumber.toString("2").padStart(5, "0")
    );
  }
  orderedLineArrayInstruction.push("01010");

  let insCode = 0;
  if (orderedLineArray[0] == "add") insCode = 32;
  if (orderedLineArray[0] == "sub") insCode = 34;
  if (orderedLineArray[0] == "and") insCode = 36;
  if (orderedLineArray[0] == "or") insCode = 37;

  orderedLineArrayInstruction.push(insCode.toString(2).padStart(6, "0"));

  return orderedLineArrayInstruction.join("") + ` //${line}`;
}

function parseDataMoving(line = "") {
  let orderedLineArray = [];
  let orderedLineArrayInstruction = [];

  if (line.indexOf("lw") != -1) orderedLineArray.push("lw");
  else if (line.indexOf("sw") != -1) orderedLineArray.push("sw");

  let cutLineAt = line.indexOf("$");
  let cutLine = "";
  cutLine = line.substring(cutLineAt);

  orderedLineArray.push(cutLine.split(",")[0]);
  orderedLineArray.push(
    cutLine.split("(")[1].substring(0, cutLine.split("(")[1].indexOf(")"))
  );
  orderedLineArray.push(
    cutLine.split(",")[1].substring(0, cutLine.split(",")[1].indexOf("("))
  );

  orderedLineArray = orderedLineArray.map(string => {
    while (string.indexOf(" ") != -1) string = string.replace(" ", "");
    return string;
  });

  if (line.indexOf("lw") != -1) orderedLineArrayInstruction.push("001011");
  if (line.indexOf("sw") != -1) orderedLineArrayInstruction.push("001100");

  //Checagem para geração de NOPs
  let higherRegisterUsage = 0;
  for (let i = 1; i < 3; i++) {
    let registerNumber = registerStringToNumber(orderedLineArray[i]);

    if (higherRegisterUsage < registerUsageBank[registerNumber])
      higherRegisterUsage = registerUsageBank[registerNumber];
  }
  //Geração de NOPs
  for (let j = 0; j < higherRegisterUsage; j++) {
    console.log(parseInstruction("nop"));
  }

  for (let i = 1; i < 3; i++) {
    let registerNumber = registerStringToNumber(orderedLineArray[i]);

    //Supondo 3 NOPs (4 instruções no pipeline)
    registerUsageBank[registerNumber] = 4;

    orderedLineArrayInstruction.push(
      registerNumber.toString("2").padStart(5, "0")
    );
  }

  orderedLineArrayInstruction.push(
    parseInt(orderedLineArray[3])
      .toString("2")
      .padStart(16, "0")
  );

  for (let j = 0; j < higherRegisterUsage; j++) {
    decreaseRegisterUsageBank();
    console.log(parseArithmetic("nop"));
  }

  return orderedLineArrayInstruction.join("") + ` //${line}`;
}

function registerStringToNumber(registerString = "") {
  if (registerString == "$s0") return 0;
  if (registerString == "$s1") return 1;
  if (registerString == "$s2") return 2;
  if (registerString == "$s3") return 3;
  if (registerString == "$s4") return 4;
  if (registerString == "$s5") return 5;
  if (registerString == "$s6") return 6;
  if (registerString == "$s7") return 7;
  if (registerString == "$t0") return 8;
  if (registerString == "$t1") return 9;
  if (registerString == "$t2") return 10;
  if (registerString == "$t3") return 11;
  if (registerString == "$t4") return 12;
  if (registerString == "$t5") return 13;
  if (registerString == "$t6") return 14;
  if (registerString == "$t7") return 15;
}

function decreaseRegisterUsageBank() {
  for (let i = 0; i < 16; i++) {
    if (registerUsageBank[i] > 0) registerUsageBank[i]--;
  }
}
