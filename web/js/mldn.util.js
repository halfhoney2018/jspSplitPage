// 针对于指定的元素进行表单数据是否为空的验证，错误层ID为“xxxDiv”、错误信息ID为“xxxSPan”
function validateEmpty(elementName) {
	elementObject = document.getElementById(elementName) ; // 获取指定的元素
	if (elementObject == undefined) {
		return false ;
	}
	if (elementObject.value == "") {
		setErrorFlag(elementName) ;
		return false ;
	} else {
		setSuccessFlag(elementName) ;
		return true ;
	}
}
function validateRegex(elementName,regex) {
	elementObject = document.getElementById(elementName) ; // 获取指定的元素
	if (elementObject == undefined) {
		return false ;
	}
	if (regex.test(elementObject.value)) {	// 验证通过
		setSuccessFlag(elementName) ;
		return true ;
	} else {
		setErrorFlag(elementName) ;
		return false ;
	}
}
function validateLessOne(elementName) {	// 至少选中一个
	elementObject = document.all(elementName) ;
	if (elementObject == undefined) {
		return false ;
	}
	if (elementObject.length == undefined) {	// 一个选项
		if (elementObject.checked) {	// 选中了
			setSuccessFlag(elementName) ;
			return true ;
		} else {
			setErrorFlag(elementName) ;
			return false ;
		}
	} else {
		count = 0 ;
		for (x = 0 ; x < elementObject.length ; x ++) {
			if (elementObject[x].checked) {
				count ++ ;
			}
		}
		if (count == 0) {	// 没有选中项
			setErrorFlag(elementName)
			return false ;
		} else {
			setSuccessFlag(elementName)
			return true ;
		}
	}
}
function setSuccessFlag(elementName) {
	document.getElementById(elementName + "Div").className = "form-group has-success" ;
	document.getElementById(elementName + "Span").innerHTML = "内容输入正确！" ;
	document.getElementById(elementName + "Span").className = "text-success" ;
}
function setErrorFlag(elementName) {
	document.getElementById(elementName + "Div").className = "form-group has-error" ;
	document.getElementById(elementName + "Span").innerHTML = "该组件的内容不允许为空！" ;
	document.getElementById(elementName + "Span").className = "text-danger" ;
}