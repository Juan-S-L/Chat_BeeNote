const fs = require('fs');
const path = require('path');

// Carga las listas de palabras groseras desde los archivos CSV
const loadBadWords = (language) => {
  const filePath = path.join(__dirname, 'bad-words', `${language}.csv`);
  const fileContent = fs.readFileSync(filePath, 'utf-8');
  return fileContent.split('\n').map((word) => word.trim());
};

const badWordsEn = loadBadWords('english');
const badWordsEs = loadBadWords('spanish');

// Función para limpiar el texto
const cleanText = (text) => {
  const cleanedText = text.split(/\s+/).map((word) => {
    if (badWordsEn.includes(word.toLowerCase()) || badWordsEs.includes(word.toLowerCase())) {
      return '*****';
    }
    return word;
  }).join(' ');
  return cleanedText;
};

module.exports = {
  cleanText,
};