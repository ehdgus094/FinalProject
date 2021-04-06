$(document).ready(function(){
	$("#loc").click(function(e){
		e.preventDefault();
		var nWidth = "490";
		var nHeight = "630";	
		var xPos = (document.body.clientWidth / 2) - (nWidth / 2); 
		xPos += window.screenLeft;	 //듀얼 모니터
		var yPos = (screen.availHeight / 2) - (nHeight / 2);
		window.open("sub/loc","location","width="+nWidth+",height="+nHeight+", left="+xPos+", top="+yPos+", toolbars=no, resizable=yes, scrollbars=no");
		
		
	})
	
})