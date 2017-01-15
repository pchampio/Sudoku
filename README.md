# Sudoku


[![Code Climate](https://codeclimate.com/github/Drakirus/Sudoku/badges/gpa.svg)](https://codeclimate.com/github/Drakirus/Sudoku)
[![Issue Count](https://codeclimate.com/github/Drakirus/Sudoku/badges/issue_count.svg)](https://codeclimate.com/github/Drakirus/Sudoku)
[![Inline docs](http://inch-ci.org/github/Drakirus/Sudoku.svg?branch=master)](http://inch-ci.org/github/Drakirus/Sudoku)


L3 SPI Réalisation d'une interface à "aides visuelles" à la résolution  d'un Sudoku 

### Installation
```
git clone https://github.com/Drakirus/Sudoku.git
cd Sudoku
gem install bundler
bundle install --path vendor/bundle
```

### Exécution
`bundler exec ruby ./main.rb`

### Tests unitaire
* Utilisation du Framework [Minitest](https://github.com/seattlerb/minitest) 
  - [Documentation](http://docs.seattlerb.org/minitest/)
  - [Exemple](https://github.com/Drakirus/Sudoku/blob/master/test/cell_test.rb)

```
bundler exec rake
google-chrome-stable ./coverage/index.html
```

### Documentation

[Online-Doc](https://sudoku.drakirus.xyz/)  

```
rdoc
google-chrome-stable ./doc/index.html
```
