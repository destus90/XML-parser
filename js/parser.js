function loadXMLDoc(filename) {
    if (window.ActiveXObject) {
        xhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    else {
        xhttp = new XMLHttpRequest();
    }
    xhttp.open("GET", filename, false);
    try { xhttp.responseType = "msxml-document" } catch (err) { } // Helping IE11
    xhttp.send(null);
    return xhttp.responseXML;
}
function displayResult() {
    xml = loadXMLDoc("../xml.xml");
    xsl = loadXMLDoc("../xsl.xslt");    
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document") {
        ex = xml.transformNode(xsl);
        document.getElementById("example").innerHTML = ex;
    }
        // code for Chrome, Firefox, Opera
    else if (document.implementation && document.implementation.createDocument) {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToFragment(xml, document);
        document.getElementById("example").appendChild(resultDocument);
    }
}

window.onload = displayResult;