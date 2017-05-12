# Sudoku


<p align="center">
<a href="https://codeclimate.com/github/Drakirus/Sudoku"><img src="https://codeclimate.com/github/Drakirus/Sudoku/badges/gpa.svg" alt="Code Climate"></a>
<a href="https://codeclimate.com/github/Drakirus/Sudoku"><img src="https://codeclimate.com/github/Drakirus/Sudoku/badges/issue_count.svg" alt="Issue Count"></a>
<a href="http://inch-ci.org/github/Drakirus/Sudoku"><img src="http://inch-ci.org/github/Drakirus/Sudoku.svg?branch=master" alt="Inline docs"></a>
<a href="https://codeclimate.com/github/Drakirus/Sudoku/coverage"><img src="https://codeclimate.com/github/Drakirus/Sudoku/badges/coverage.svg" alt="Test Coverage"></a>
<a href="https://travis-ci.org/Drakirus/Sudoku"><img src="https://travis-ci.org/Drakirus/Sudoku.svg" alt="Build Status"></a>
</p>

L3 SPI Réalisation d'une interface à "aides visuelles" à la résolution  d'un Sudoku 

<p align="center">
  <a href="https://raw.githubusercontent.com/Drakirus/Sudoku/master/screen.png">
    <img alt="ScreenShot~ prompt" src="https://raw.githubusercontent.com/Drakirus/Sudoku/master/screen.png">
  </a>
</p>

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
bundler install
# or bundler install --path vendor/bundle
```

### Exécution
`./Start.rb`

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
## Gtk3-Doc

[Doc_Gtk3](https://lazka.github.io/pgi-docs/Gtk-3.0/classes.html)  
[gtk-demo](https://github.com/ruby-gnome2/ruby-gnome2/tree/master/gtk3/sample/gtk-demo)
