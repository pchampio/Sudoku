# Sudoku


[![Code Climate](https://codeclimate.com/github/Drakirus/Sudoku/badges/gpa.svg)](https://codeclimate.com/github/Drakirus/Sudoku)
[![Issue Count](https://codeclimate.com/github/Drakirus/Sudoku/badges/issue_count.svg)](https://codeclimate.com/github/Drakirus/Sudoku)
[![Inline docs](http://inch-ci.org/github/Drakirus/Sudoku.svg?branch=master)](http://inch-ci.org/github/Drakirus/Sudoku)
[![Test Coverage](https://codeclimate.com/github/Drakirus/Sudoku/badges/coverage.svg)](https://codeclimate.com/github/Drakirus/Sudoku/coverage)
[![Build Status](https://travis-ci.org/Drakirus/Sudoku.svg)](https://travis-ci.org/Drakirus/Sudoku)


L3 SPI Réalisation d'une interface à "aides visuelles" à la résolution  d'un Sudoku 

### Recommandé: Rvm Installation
```
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm autolibs disable
rvm requirements
rvm install ruby-2.4.0
rvm 2.4.0
```

### Installation  
```
git clone https://github.com/Drakirus/Sudoku.git
cd Sudoku
# Utilisation de Rvm recommandé
gem install bundler
bundler install --path vendor/bundle
```

### Exécution
`bundler exec ruby ./Start.rb`

### Tests unitaire
* Utilisation du Framework [Minitest](https://github.com/seattlerb/minitest) 
  - [Documentation](http://docs.seattlerb.org/minitest/)
  - [Exemple](https://github.com/Drakirus/Sudoku/blob/master/test/cell_test.rb)

```
bundler exec rake
google-chrome-stable ./coverage/index.html
```

### Documentation

[Online-Doc](http://sudoku.drakirus.xyz/)  
```
rdoc
google-chrome-stable ./doc/index.html
```
