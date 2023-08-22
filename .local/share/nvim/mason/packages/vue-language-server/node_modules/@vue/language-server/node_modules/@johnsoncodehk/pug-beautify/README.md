# Pug(former jade) beautify
This tiny program format a pug(former jade) template file.
For reusability, it's made as a module suggested by [@Glavin001](https://github.com/Glavin001).
Please refer [this issue](https://github.com/vingorius/jade-beautify/issues/7).

## Installation
```shell
npm install pug-beautify
```
## Test
```shell
npm run test
```
### Options
* fill_tab - boolean, fill whether tab or space, default true.
* omit_div - boolean, whether omit 'div' tag, default false.
* tab_size - number, when 'fill_tab' is false, fill 'tab_size' spaces, default 4.
* separator_space - boolean, When 'separator_space' is true, the attribute separator is comma, default true.
* omit_empty_lines - When 'separator_space' is false, delete line blank, default true.

## How to use
```javascript
var output = pugBeautify(code);
```
```javascript
var output = pugBeautify(code,{
    fill_tab:true,
    omit_div:false,
    tab_size:4,
    separator_space:true,
});
```

## Example code
```javascript
var fs = require('fs');
var pugBeautify = require('pug-beautify');
var code = fs.readFileSync('sample.jade','utf8');
var option = {
    fill_tab: true,
    omit_div: false,
    tab_size: 4,
    separator_space: true
};
try {
    var output = pugBeautify(code,option);
}catch(error){
    // Error occurred
}
```
## Todo
