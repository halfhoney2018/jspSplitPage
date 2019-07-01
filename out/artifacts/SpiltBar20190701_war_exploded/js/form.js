max = 20 ; // 设置最大的输入长度
window.onload = function() {	// 所有的处理事件都通过加载操作完成
	document.getElementById("birthday").addEventListener("click",WdatePicker,false) ;
	document.getElementById("empno").addEventListener("blur",validateEmpno,false) ;
	document.getElementById("ename").addEventListener("blur",validateEname,false) ;
	document.getElementById("sal").addEventListener("blur",validateSal,false) ;
	document.getElementById("comm").addEventListener("blur",validateComm,false) ;
	roleObject = document.all("role") ;
	if (roleObject.length == undefined) {
		roleObject.addEventListener("click",validateRole,false) ;
	} else {
		for (x = 0 ; x < roleObject.length ; x ++) {
			roleObject[x].addEventListener("click",validateRole,false) ;
		}
	}
	document.getElementById("job").addEventListener("blur",validateJob,false) ;
	document.getElementById("dept").addEventListener("blur",validateDept,false) ;
	document.getElementById("empform").addEventListener("submit",function(event){
		if (!(validateEmpno() & validateEname() & 
				validateBirthday() & validateSal() & validateComm() |
				validateJob() & validateRole() & validateDept())) {
			event.preventDefault() ;
		}
	},false) ; 
}
function validateEmpno() {
	return validateRegex("empno",/^emp\-\d{6}$/) ;
}
function validateEname() { 
	return validateEmpty("ename") ;
}
function validateBirthday() {
	return validateEmpty("birthday") ;
}
function validateSal() {
	return validateRegex("sal",/^\d{1,10}(\.\d{1,2})?$/) ;
}
function validateComm() {
	job = document.getElementById("job").value ; // 获取职位信息
	if (job == "销售人员") {
		return validateRegex("comm",/^\d{1,10}(\.\d{1,2})?$/) ;
	}
	return true ;
}
function validateJob() {
	return validateEmpty("job") ;
}
function validateRole() {
	return validateLessOne("role") ;
}
function validateDept() {
	return validateEmpty("dept") ;
}