if(process.argv.length!=2+3){
	console.log("模版文件 参数文件(JSON5) 输出文件");
	process.exit();
	helpAndExit()
}
const JSON5 = require('json5');
const ejs = require('ejs');
const fs = require("fs");
const path = require("path");

function ensureDirectoryExistence(filePath) {
	var dirname = path.dirname(filePath);
	if (fs.existsSync(dirname)) {
		return true;
	}
	ensureDirectoryExistence(dirname);
	fs.mkdirSync(dirname);
}
function getAllFiles(dirpath, result) {
	if(!result){
		result = [];
	}
    fs.readdirSync(dirpath).forEach(function(file){
		var fullFilePath = path.join(dirpath,file);
        var states = fs.statSync(fullFilePath);
        if (states.isDirectory()) {
            getAllFiles(fullFilePath, result);
        } else {
            result.push(fullFilePath);
        }
    });
	return result;
}
function deleteFolder(dirpath) {
	if(fs.existsSync(dirpath)) {
		fs.readdirSync(dirpath).forEach(function(file){
			var curPath = path.join(dirpath, file);
			if(fs.statSync(curPath).isDirectory()) {
				deleteFolder(curPath);
			} else {
				fs.unlinkSync(curPath);
			}
		});
		fs.rmdirSync(dirpath);
	}
}
function copyFolder(sourcedir, targetdir) {
	files = fs.readdirSync(sourcedir);
	if (!fs.existsSync(targetdir)) {
		fs.mkdirSync(targetdir);
	}
	files.forEach(function(file){
		var sourceFile = path.join(sourcedir, file);
		var targetFile = path.join(targetdir, file);
		if(fs.statSync(sourceFile).isDirectory()) {
			copyFolder(sourceFile, targetFile);
		} else {
			fs.writeFileSync(targetFile,fs.readFileSync(sourceFile));
		}
	});
}

function renderFile(templateFilePath, outputFilePath, obj_data){
	var str_template = fs.readFileSync(templateFilePath,"utf-8");
	var str_rendered = ejs.render(str_template, obj_data, {
		"escape": function(str){
			return str;
		}
	});
	fs.writeFileSync(outputFilePath,str_rendered,"utf-8");
}

var str_data = process.argv[3];
var obj_data = JSON5.parse(str_data);


var templateFilePath = process.argv[2];

var outputFilePath = process.argv[4];
ensureDirectoryExistence(outputFilePath);

if(fs.statSync(templateFilePath).isDirectory()) {
	deleteFolder(outputFilePath);
	copyFolder(templateFilePath,outputFilePath);
	getAllFiles(outputFilePath).forEach(function(fullFilePath){
		if(fullFilePath.endsWith(".ejs")){
			var targetFile = fullFilePath.substr(0,fullFilePath.length-4);
			renderFile(fullFilePath, targetFile, obj_data);
			fs.unlinkSync(fullFilePath);
		}
	});
}else{
	renderFile(templateFilePath, outputFilePath, obj_data);
}