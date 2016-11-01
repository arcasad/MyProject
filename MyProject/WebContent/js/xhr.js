/**
 * getXMLHttpRequest * sendRequest()
 */
var xhr = null;

function sendRequest(url, params, callback, method){
	xhr = getXMLHttpRequest();
	
	var httpMethod = method ? method.toUpperCase() : 'GET';
	if(httpMethod!='GET' && httpMethod!='POST'){
		httpMethod='GET';
	}
	var httpParams = (params==null || params=='') ? null: params;
	var httpUrl = url;
	if(httpMethod=='GET' && httpParams!=null){
		httpUrl = httpUrl + '?' + httpParams;
	}
	xhr.open(httpMethod, httpUrl, true);
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.onreadystatechange = callback;
	xhr.send(httpMethod=='POST'? httpParams:null);
}

function getXMLHttpRequest(){
	
	if(window.ActiveXObject){//explorer 4~8
		
		var versions = [
		                'Msxml2.XMLHTTP.6.0',
		                'Msxml2.XMLHTTP.5.0',
		                'Msxml2.XMLHTTP.4.0',
		                'Msxml2.XMLHTTP.3.0',
		                'Msxml2.XMLHTTP.2.0',
		                'Msxml2.XMLHTTP',
		                'Microsoft.XMLHTTP'
		                ];
		
		for(var i=0; i<version.length; i++){
			try {
				return new ActiveXObject(i);
			} catch (e) {}
		}	
	} else if(window.XMLHttpRequest){
		try {
			return new XMLHttpRequest();
		} catch (e) {
			return null;
		}
	} else{
		return null;
	}
}