function getObj(name) {
  if (document.getElementById)
    return document.getElementById(name);
  else if (document.all)
    return document.all[name];
  else if (document.layers)
    return document.layers[name];
}






function createMatrix() {
  var newDiv=document.createElement("div");
       
  var newTable=document.createElement("table");
  newTable.setAttribute('id','matrix');
       
  var tHead=document.createElement("thead");
  var newTr=document.createElement("tr");
  var newTh=document.createElement("th");
  newTr.appendChild(newTh);

  for (var x=0;x<Rank.length;x++) {
    newTh=document.createElement("th");
    newTh.setAttribute('id','colHead'+x);
    newTh.setAttribute('align','center');
    newTh.setAttribute('width','20');//FIXME - unflexibel
    var newB=document.createElement("b");
    newB.appendChild(document.createTextNode(unescape("%"+(x+41))));
    newTh.appendChild(newB);
    newTr.appendChild(newTh);
  }
  tHead.appendChild(newTr);
  newTable.appendChild(tHead);

  var tBody=document.createElement("tbody");

  //main part
  for (var y=0;y<Rank.length;y++) {
    newTr=document.createElement("tr");	  

    var newTd=document.createElement("td");
    newTd.setAttribute('id','rowHead'+y);
    var newB=document.createElement("b");
    newB.appendChild(document.createTextNode(Candidates[y]+" ("+unescape("%"+(y+41))+")"));
    newTd.appendChild(newB);
    newTr.appendChild(newTd);

    for (var x=0;x<Rank.length;x++) {
      var newTd=document.createElement("td");
      newTd.setAttribute('id',x+","+y);
      if (x==y) newTd.appendChild(document.createTextNode("-"));
      else {
	newTd.appendChild(document.createTextNode(""));
	newTd.setAttribute("onmouseover","highlightHeaders("+x+","+y+");");
	newTd.setAttribute("onmouseout","unHighlightHeaders("+x+","+y+");");
      }
      newTd.setAttribute('align','center');

      newTr.appendChild(newTd);
    }
    tBody.appendChild(newTr);
	
  }

  newTable.appendChild(tBody);
  newDiv.appendChild(newTable);
	
  var newP=document.createElement("p");
  newFieldLegend=document.createElement("b");
  newFieldLegend.setAttribute('id','fieldLegend');
  newFieldLegend.appendChild(document.createTextNode(""));
  newFieldLegend.appendChild(document.createElement("br"));
	
  newP.appendChild(newFieldLegend);
  newDiv.appendChild(newP);

  return newDiv;
}


function highlightHeaders(x,y){
  getObj(x+","+y).setAttribute('class','highlighted');
  getObj("colHead"+x).setAttribute('class','highlighted');
  getObj("rowHead"+y).setAttribute('class','highlighted');
  var orderString="";
  if (getObj(x+","+y).firstChild.data==loseValue) var orderString=" gets beaten by ";
  else if (getObj(x+","+y).firstChild.data==remisValue) var orderString=" equally ranked to ";
  else var orderString=" beats ";
  getObj("fieldLegend").firstChild.data=Candidates[y]+orderString+Candidates[x];
}

function unHighlightHeaders(x,y) {
  getObj(x+","+y).removeAttribute('class');
  getObj("colHead"+x).removeAttribute('class');
  getObj("rowHead"+y).removeAttribute('class');
  getObj("fieldLegend").firstChild.data="";
}


function updateMatrix() {
  for (var x=0; x<Rank.length; x++) {
    for (var y=0; y<x; y++) {
      if (Rank[x]<Rank[y]) {
	getObj(x+","+y).firstChild.data=loseValue;
	getObj(y+","+x).firstChild.data=winValue;
      } else if (Rank[x]==Rank[y]) {
	getObj(x+","+y).firstChild.data=remisValue;
	getObj(y+","+x).firstChild.data=remisValue;
      } else {
	getObj(x+","+y).firstChild.data=winValue;
	getObj(y+","+x).firstChild.data=loseValue;
      }
    }
  }
}


function updateRankTable() {
  getObj("rankTable").removeChild(getObj("rankTable").lastChild);
  var newTbody=document.createElement("tbody");
  // Rank number
  for (var i=0; i<lastRank; i++) {
    var newTr=document.createElement("tr");
    var newTd=document.createElement("td");
    newTd.setAttribute('style','text-align:center');
    newTd.appendChild(document.createTextNode(i+1));
    newTr.appendChild(newTd);
    newTd=document.createElement("td");
    newTr.appendChild(newTd);
	  
    newTbody.appendChild(newTr);	  
  }
	
  for (var i=0;i<Candidates.length;i++) {
    var newCand=document.createElement("div");
    newCand.setAttribute('onclick','Mark(this)');
    //newCand.onclick='Mark(this)';
    newCand.setAttribute('class','unmarked');
    newCand.setAttribute('id',i);
    newCand.appendChild(document.createTextNode(Candidates[i]));
    newTbody.childNodes[Rank[i]-1].lastChild.appendChild(newCand);
  }      
  getObj("rankTable").appendChild(newTbody);
	
  updateMatrix();
}


function createRankTable() {
	
  var newDiv=document.createElement("newDiv");
  var newTable=document.createElement("table");
  newTable.setAttribute('id','rankTable');
  var newTelement=document.createElement("thead");
  var newTr=document.createElement("tr");
  var newTd=document.createElement("th");
  newTd.appendChild(document.createTextNode("Rank"));
  newTr.appendChild(newTd);

  newTd=document.createElement("th");
  newTd.appendChild(document.createTextNode("Candidate"));
  newTd.setAttribute('width','150');
  newTr.appendChild(newTd);
       
  newTelement.appendChild(newTr);
  newTable.appendChild(newTelement);
  newTelement=document.createElement("tbody");

  newTable.appendChild(newTelement);
  newDiv.appendChild(newTable);

  newForm=document.createElement("form");
  newInput=document.createElement("input");
  newInput.setAttribute('type','checkbox');
  newInput.setAttribute('checked','checked');
  newInput.setAttribute('id','allowMultiple');
  newForm.appendChild(newInput);
  newForm.appendChild(document.createTextNode("Allow Multiple Selections"));
  newForm.appendChild(document.createElement("br"));

  var newButton=document.createElement("button");
  newForm.setAttribute('style','text-align:center');
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','RESET');
  newButton.setAttribute('onclick','resetRankTable();updateRankTable();');
  newButton.appendChild(document.createTextNode("Reset"));
  newForm.appendChild(newButton);

  newDiv.appendChild(newForm);
	
  return newDiv;
}


function Insert(elem,arrayList){
  //ugly...

  var newArray=new Array();

  if (arrayList.length==0) {
    //alert("Schiebe A "+Candidates[elem.getAttribute('id')]);
    newArray.push(elem); 
  }
  else {
    var inserted=false;
    for (var j=0; j<arrayList.length; j++) {
      if ((Rank[elem.getAttribute('id')]<Rank[arrayList[j].getAttribute('id')]) && (!inserted)) {
	newArray.push(elem);
	//alert("Schiebe B "+Candidates[elem.getAttribute('id')]);
	inserted=true;
      }
      newArray.push(arrayList[j]);
      // alert("Schiebe C"+Candidates[arrayList[j].getAttribute('id')]);
    }
    if (!inserted) newArray.push(elem);
  }
	
  return newArray;
}


function MarkedElements() {
  var Marked=new Array();
  for (var i=0;i<Rank.length;i++) 
    if (getObj(i).getAttribute('class')=='marked') Marked=Insert(getObj(i),Marked);
  return Marked;
}
			
function Mark(x) {
  if (getObj("allowMultiple").checked==false) {
	  
    for (var i=0;i<Rank.length;i++)
      if (getObj(i).getAttribute('class')=='marked') getObj(i).setAttribute('class','unmarked');
  }
      
  if (x.getAttribute('class')=='marked') x.setAttribute('class','unmarked'); else x.setAttribute('class','marked');
}


function MoveFirst() {
  Elem=MarkedElements();

  if (Elem.length>0) {

    var newRow=document.createElement("tr");
    getObj("rankTable").lastChild.insertBefore(newRow,getObj("rankTable").lastChild.childNodes[0]);

    var newTd=document.createElement("td");
    newTd.setAttribute('style','text-align:center;vertical-align:middle');
    newTd.appendChild(document.createTextNode("1"));
    newRow.appendChild(newTd);
    var newField=document.createElement("td");

    for (var i=0; i<Rank.length;i++) {
      Rank[i]++;
      if (v) alert("setze "+Candidates[i]+" auf "+Rank[i]);	    
    }
	  
    lastRank++;
            
    for (var i=0; i<Elem.length; i++){
      var oldField=Elem[i].parentNode;
      newField.appendChild(Elem[i]);
      if (!oldField.hasChildNodes()) {
	oldField.parentNode.parentNode.removeChild(oldField.parentNode);
	for (var j=0;j<Rank.length;j++) if (Rank[j]>Rank[Elem[i].getAttribute('id')]) {
	  Rank[j]--;
	  if (v) alert("setze "+Candidates[j]+" auf "+Rank[j]);
	}
	lastRank--;
      }
      Rank[Elem[i].getAttribute('id')]=1;
      if (v) alert("setze "+Elem[i].lastChild.data+" auf "+Rank[Elem[i].getAttribute('id')]);	    
    }  
    newRow.appendChild(newField);

    for (var i=1; i<lastRank; i++) getObj("rankTable").lastChild.childNodes[i].firstChild.firstChild.data=i+1;
  } 
  if (c) check();
  updateMatrix();
}
 
           
function MoveLast() {
  Elem=MarkedElements();

  if (Elem.length>0) {

    lastRank++;
    var firstDeletion=lastRank;

    var newRow=document.createElement("tr");
    getObj("rankTable").lastChild.appendChild(newRow);

    var newTd=document.createElement("td");
    newTd.setAttribute('style','text-align:center;vertical-align:middle');
    newTd.appendChild(document.createTextNode(lastRank));
    newRow.appendChild(newTd);
    var newField=document.createElement("td");            


    for (var i=0; i<Elem.length; i++){
      var oldField=Elem[i].parentNode;
      newField.appendChild(Elem[i]);
      if (!oldField.hasChildNodes()) {
	oldField.parentNode.parentNode.removeChild(oldField.parentNode);
	for (var j=0;j<Rank.length;j++) if (Rank[j]>Rank[Elem[i].getAttribute('id')]) {
	  Rank[j]--;
	  if (v) alert("setze "+Candidates[j]+" auf "+Rank[j]);	
	}
	lastRank--;
	if (Rank[Elem[i].getAttribute('id')]<firstDeletion) firstDeletion=Rank[Elem[i].getAttribute('id')];
      }
      Rank[Elem[i].getAttribute('id')]=lastRank;
      if (v) alert("setze "+Elem[i].lastChild.data+" auf "+Rank[Elem[i].getAttribute('id')]);	    
    }  
    newRow.appendChild(newField);
    for (var i=firstDeletion-1; i<lastRank; i++) getObj("rankTable").lastChild.childNodes[i].firstChild.firstChild.data=i+1;
  }
  if (c) check();   
  updateMatrix();
}


function MoveUp() {
  Elem=MarkedElements();
  if (Elem.length>0) {
	  
    Elem.reverse();
    ElemGroup=new Array();
	  
    var j=0;
    while (j<=Elem.length) {
  
      if ((j!=Elem.length)&&((ElemGroup.length==0)||(ElemGroup[0].parentNode==Elem[j].parentNode))) {
	ElemGroup.push(Elem[j]);
	j++;
      }
      else {
	if (j==Elem.length) j++;

	if (ElemGroup[0].parentNode.childNodes.length==ElemGroup.length) {
	  if (Rank[ElemGroup[0].getAttribute('id')]>1) {

	    //alert("Vollständige ElemGroup, nicht an erster Stelle");

	    var prevRankFullMarked=true;

	    for (var i=0; i<getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[0].getAttribute('id')]-2].lastChild.childNodes.length; i++) if (getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[0].getAttribute('id')]-2].lastChild.childNodes[i].getAttribute('class')!='marked') prevRankFullMarked=false;

	    if (!prevRankFullMarked) {
		  
	
	      for (var i=0; i<Rank.length; i++) if (Rank[i]>Rank[ElemGroup[0].getAttribute('id')]) {
		Rank[i]--;
		if (v) alert("setze "+Candidates[i]+" auf "+Rank[i]);
	      }
		    
	      var oldField=ElemGroup[0].parentNode;
		    
	      for (var i=0; i<ElemGroup.length; i++){
		      
		      
		getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[i].getAttribute('id')]-2].lastChild.appendChild(ElemGroup[i]);
		      
		Rank[ElemGroup[i].getAttribute('id')]--;
		if (v) alert("setze "+ElemGroup[i].lastChild.data+" auf "+Rank[ElemGroup[i].getAttribute('id')]);
	      } 
	      oldField.parentNode.parentNode.removeChild(oldField.parentNode);
	      lastRank--;
	    }
	  }
	} else {

	  //alert("Unvollständige ElemGroup");
                
	  var newRow=document.createElement("tr");
	  getObj("rankTable").lastChild.insertBefore(newRow,getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[0].getAttribute('id')]-1]);


	  var newTd=document.createElement("td");
	  newTd.setAttribute('style','text-align:center;vertical-align:middle');
	  newTd.appendChild(document.createTextNode(Rank[ElemGroup[0].getAttribute('id')]));
	  newRow.appendChild(newTd);
       
	  var newField=document.createElement("td");
            
	  oldRank=Rank[ElemGroup[0].getAttribute('id')];
	  for (var i=0; i<Rank.length;i++) if (Rank[i]>=oldRank) {
	    Rank[i]++;
	    if (v) alert("setze "+Candidates[i]+" auf "+Rank[i]);
	  }

	  for (var i=0; i<ElemGroup.length; i++){
	    //var oldField=ElemGroup[i].parentNode;
	    newField.appendChild(ElemGroup[i]);
	    Rank[ElemGroup[i].getAttribute('id')]--;
	    if (v) alert("setze "+ElemGroup[i].lastChild.data+" auf "+Rank[ElemGroup[i].getAttribute('id')]);
	  }
	  newRow.appendChild(newField);
      
	  lastRank++;
	}              
	ElemGroup.splice(0,ElemGroup.length);
      }
    }
    for (var i=0; i<lastRank; i++) getObj("rankTable").lastChild.childNodes[i].firstChild.firstChild.data=i+1;
  }
  if (c) check();
  updateMatrix();
}


      

function MoveDown() {
  Elem=MarkedElements();
  if (Elem.length>0) {
	            
    //Elem.reverse();

    ElemGroup=new Array();
	  
    var j=0;
    while (j<=Elem.length) {
	    
      if ((j!=Elem.length)&&((ElemGroup.length==0)||(ElemGroup[0].parentNode==Elem[j].parentNode))) {
	ElemGroup.push(Elem[j]);
	j++;
      }
      else {
	if (j==Elem.length) j++;

	if (ElemGroup[0].parentNode.childNodes.length==ElemGroup.length) {
	  if (Rank[ElemGroup[0].getAttribute('id')]<lastRank) {

	    //alert("Vollständige ElemGroup, nicht an letzter Stelle");
		  
	    var nextRankFullMarked=true;

	    //alert(Candidates[ElemGroup[0].getAttribute("id")]+" hat drunter "+getObj('rankTable').lastChild.childNodes[Rank[ElemGroup[0].getAttribute('id')]].lastChild.childNodes.length+" Knoten.");

	    for (var i=0; i<getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[0].getAttribute('id')]].lastChild.childNodes.length; i++) if (getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[0].getAttribute('id')]].lastChild.childNodes[i].getAttribute('class')!='marked') nextRankFullMarked=false;
		  
	    //alert(nextRankFullMarked);
	    if (!nextRankFullMarked) {
		  
	      for (var i=0; i<Rank.length; i++) if (Rank[i]>Rank[ElemGroup[0].getAttribute('id')]) {
		Rank[i]--;
		if (v) alert("setze "+Candidates[i]+" auf "+Rank[i]);
	      }
		    
	      var oldField=ElemGroup[0].parentNode;
		    
	      for (var i=0; i<ElemGroup.length; i++){
		getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[i].getAttribute('id')]].lastChild.appendChild(ElemGroup[i]);
		    
	      } 
	      oldField.parentNode.parentNode.removeChild(oldField.parentNode);
	      lastRank--;
		    		  
	    }

	  } 
	} else {

	  //alert("Unvollständige ElemGroup");
                
	  var newRow=document.createElement("tr");
	  getObj("rankTable").lastChild.insertBefore(newRow,getObj("rankTable").lastChild.childNodes[Rank[ElemGroup[0].getAttribute('id')]]);

	  var newTd=document.createElement("td");
	  newTd.setAttribute('style','text-align:center;vertical-align:middle');
	  newTd.appendChild(document.createTextNode(Rank[ElemGroup[0].getAttribute('id')]+1));
	  newRow.appendChild(newTd);

	  var newField=document.createElement("td");
            
	  //oldRank=Rank[ElemGroup[0].getAttribute('id')];
	  for (var i=0; i<Rank.length;i++) if (Rank[i]>Rank[ElemGroup[0].getAttribute('id')]) {
	    Rank[i]++;
	    if (v) alert("setze "+Candidates[i]+" auf "+Rank[i]);
	  }

	  for (var i=0; i<ElemGroup.length; i++){
	    //var oldField=ElemGroup[i].parentNode;
	    newField.appendChild(ElemGroup[i]);

	    Rank[ElemGroup[i].getAttribute('id')]++;
	    if (v) alert("setze "+ElemGroup[i].lastChild.data+" auf "+Rank[ElemGroup[i].getAttribute('id')]);
	  }
	  newRow.appendChild(newField);
      
	  lastRank++;
	}              
	ElemGroup.splice(0,ElemGroup.length);
      }
    }
    for (var i=0; i<lastRank; i++) getObj("rankTable").lastChild.childNodes[i].firstChild.firstChild.data=i+1;
  }

  if (c) check();
  updateMatrix();
}


function addCandidate() {
  if (getObj("addInput").value!="") {
    newP=document.createElement("option");
    newP.appendChild(document.createTextNode(getObj("addInput").value));
    getObj("candList").appendChild(newP);
    getObj("addInput").value="";
  }
}

function removeSelected() {
  for (var i=getObj("candList").childNodes.length-1; i>=0; i--) {
    if (getObj("candList").childNodes[i].selected)
      getObj("candList").removeChild(getObj("candList").childNodes[i]);
  }
}

function removeAll(){
  for (var i=getObj("candList").childNodes.length-1; i>=0; i--)
    getObj("candList").removeChild(getObj("candList").childNodes[i]);
}

function acceptChanges() {
  Candidates.splice(0,Candidates.length);
  for (var i=0; i<getObj("candList").childNodes.length; i++) {
    Candidates.push(getObj("candList").childNodes[i].value);
  }
  winValue=getObj("winValue").value;
  loseValue=getObj("loseValue").value;
  remisValue=getObj("remisValue").value;
  resetAll();
  exitOptions();
}
      
function exitOptions() {  //not good, should hang in the old votingDiv node.
  getObj("optionsDiv").parentNode.removeChild(getObj("optionsDiv"));
  resetAll();
  createVoting();
  //getObj("mainDiv").appendChild(votingdiv);
}


function showOptions(){
	
  //var votingDiv=getObj('votingDiv');
  getObj("votingDiv").parentNode.removeChild(getObj("votingDiv"));
	
  var newDiv=document.createElement("div");
  newDiv.setAttribute('id','optionsDiv');

  var newP=document.createElement("h2");
  newP.appendChild(document.createTextNode("Options"));
  newDiv.appendChild(newP);
  newDiv.appendChild(document.createElement("hr"));

  newP=document.createElement("h3");
  newP.appendChild(document.createTextNode("Add & Remove Candidates"));
  newDiv.appendChild(newP);
	
  //var newForm=document.createElement("form");

  var newTable=document.createElement("table");
  newTable.setAttribute('class','structure');
  newTable.setAttribute('cellspacing','15');

  var newTbody=document.createElement("tbody");
  newTable.appendChild(newTbody);
	
  var newTr=document.createElement("tr");

  var newTd=document.createElement("td");
	
  newTd.appendChild(document.createTextNode("Name"));
  newTd.appendChild(document.createElement("br"));
  var newInput=document.createElement("input");
  newInput.setAttribute('id','addInput');
  newInput.setAttribute('type','text');
  //newInput.setAttribute('onchange','addCandidate()');
  //newInput.setAttribute('size','20');
  newInput.setAttribute('maxlength','50');

  newTd.appendChild(newInput);
  newTr.appendChild(newTd);

  newTd=document.createElement("td");
  newTd.appendChild(document.createElement("br"));
  var newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','ADD');
  newButton.setAttribute('onclick','addCandidate()');
  newButton.appendChild(document.createTextNode("Add"));
  newTd.appendChild(newButton);	
  newTr.appendChild(newTd);
  newTbody.appendChild(newTr);

  newTr=document.createElement("tr");
  newTd=document.createElement("td");
	
  var newSelect=document.createElement("select");
  newSelect.setAttribute('id','candList');
  newSelect.setAttribute('multiple','multiple');
  //newSelect.setAttribute('width','50');doesn't exist
	
  for (var i=0;i<Candidates.length;i++) {
    newP=document.createElement("option");
    newP.appendChild(document.createTextNode(Candidates[i]));
    newSelect.appendChild(newP);
  }
  newTd.appendChild(newSelect);	
  newTr.appendChild(newTd);

  newTd=document.createElement("td");
  newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','REMOVE');
  newButton.setAttribute('onclick','removeSelected()');
  newButton.appendChild(document.createTextNode("Remove"));
  newTd.appendChild(newButton);
  newTd.appendChild(document.createElement("br"));
  newTd.appendChild(document.createElement("br"));
  newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','REMOVEALL');
  newButton.setAttribute('onclick','removeAll()');
  newButton.appendChild(document.createTextNode("Remove all"));
  newTd.appendChild(newButton);	
  newTr.appendChild(newTd);
	
  newTbody.appendChild(newTr);
  //newForm.appendChild(newTable);
  //newDiv.appendChild(newForm);
  newDiv.appendChild(newTable);

  newDiv.appendChild(document.createElement("hr"));

  newP=document.createElement("h3");
  newP.appendChild(document.createTextNode("Other Options"));
  newDiv.appendChild(newP);
  newP=document.createElement("h4");
  newP.appendChild(document.createTextNode("Values for translating the Ranked Table into the pairwise Matrix"));
  newDiv.appendChild(newP);

  var newForm=document.createElement("form");
	
  newTable=document.createElement("table");
  newTable.setAttribute("class","structure");
  newTbody=document.createElement("tbody");
  newTable.appendChild(newTbody);

  var newTr=document.createElement("tr");
  var newTd=document.createElement("td");
		
  newTd.appendChild(document.createTextNode("Winner"));
  newTr.appendChild(newTd);
  newTd=document.createElement("td");
  var newInput=document.createElement("input");
  newInput.setAttribute('id','winValue');
  newInput.setAttribute('type','text');
  newInput.setAttribute('size','5');
  newInput.setAttribute('maxlength','2');
  newInput.setAttribute('align','right');
  newInput.setAttribute('onFocus','this.select()');
  newInput.setAttribute('value',winValue);
  
  newTd.appendChild(newInput);
  newTr.appendChild(newTd);
	
  newTbody.appendChild(newTr);
  newTr=document.createElement("tr");
  newTd=document.createElement("td");
		
  newTd.appendChild(document.createTextNode("Loser"));
  newTr.appendChild(newTd);
  newTd=document.createElement("td");
  newInput=document.createElement("input");
  newInput.setAttribute('id','loseValue');
  newInput.setAttribute('type','text');
  newInput.setAttribute('size','5');
  newInput.setAttribute('maxlength','2');
  newInput.setAttribute('align','right');
  newInput.setAttribute('onFocus','this.select()');
  newInput.setAttribute('value',loseValue);
  
  newTd.appendChild(newInput);
  newTr.appendChild(newTd);
	
  newTbody.appendChild(newTr);
  newTr=document.createElement("tr");
  newTd=document.createElement("td");
		
  newTd.appendChild(document.createTextNode("Remis"));
  newTr.appendChild(newTd);
  newTd=document.createElement("td");
  newInput=document.createElement("input");
  newInput.setAttribute('id','remisValue');
  newInput.setAttribute('type','text');
  newInput.setAttribute('size','5');
  newInput.setAttribute('maxlength','2');
  newInput.setAttribute('align','right');
  newInput.setAttribute('onFocus','this.select()');
  newInput.setAttribute('value',remisValue);
  newTd.appendChild(newInput);
  newTr.appendChild(newTd);
	
  newTbody.appendChild(newTr);
  newForm.appendChild(newTable);
  newDiv.appendChild(newForm);

  newDiv.appendChild(document.createElement("hr"));
	
  newTable=document.createElement("table");
  newTbody=document.createElement("tbody");
  newTable.appendChild(newTbody);

  newTr=document.createElement("tr");
  newTd=document.createElement("td");

  newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','SAVE');
  newButton.setAttribute('onclick','acceptChanges()');
  newButton.appendChild(document.createTextNode("Accept changes"));
  newTd.appendChild(newButton);
  newTr.appendChild(newTd);

  newTd=document.createElement("td");
  newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','REJECT');
  newButton.setAttribute('onclick','exitOptions()');
  newButton.appendChild(document.createTextNode("Reject changes"));
  newTd.appendChild(newButton);
  newTr.appendChild(newTd);

  newTbody.appendChild(newTr);
  newDiv.appendChild(newTable);

  getObj("mainDiv").appendChild(newDiv);
}


function createRankButtons() {
  var newTable=document.createElement("table");
  newTable.setAttribute('class','structure');
  newTable.setAttribute('cellspacing','10');
	
  var newTbody=document.createElement("tbody");
	
  var newTr=document.createElement("tr");
  var newTd=document.createElement("td");
  var newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','FIRST');
  newButton.setAttribute('onclick','MoveFirst()');
  var newImg=document.createElement("img");
  newImg.setAttribute('src','img/first.png');
  newImg.setAttribute('width','28');
  newImg.setAttribute('height','28');
  newImg.setAttribute('alt','FIRST');
  newButton.appendChild(newImg);
  newTd.appendChild(newButton);
  newTr.appendChild(newTd);
  newTbody.appendChild(newTr);
	
  newTr=document.createElement("tr");
  newTd=document.createElement("td");
  newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','UP');
  newButton.setAttribute('onclick','MoveUp()');
  newImg=document.createElement("img");
  newImg.setAttribute('src','img/up.png');
  newImg.setAttribute('width','28');
  newImg.setAttribute('height','28');
  newImg.setAttribute('alt','UP');
  newButton.appendChild(newImg);
  newTd.appendChild(newButton);
  newTr.appendChild(newTd);
  newTbody.appendChild(newTr);

  newTr=document.createElement("tr");
  newTd=document.createElement("td");
  newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','DOWN');
  newButton.setAttribute('onclick','MoveDown()');
  newImg=document.createElement("img");
  newImg.setAttribute('src','img/down.png');
  newImg.setAttribute('width','28');
  newImg.setAttribute('height','28');
  newImg.setAttribute('alt','DOWN');
  newButton.appendChild(newImg);
  newTd.appendChild(newButton);
  newTr.appendChild(newTd);
  newTbody.appendChild(newTr);

  newTr=document.createElement("tr");
  newTd=document.createElement("td");
  newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','LAST');
  newButton.setAttribute('onclick','MoveLast()');
  newImg=document.createElement("img");
  newImg.setAttribute('src','img/last.png');
  newImg.setAttribute('width','28');
  newImg.setAttribute('height','28');
  newImg.setAttribute('alt','LAST');
  newButton.appendChild(newImg);
  newTd.appendChild(newButton);
  newTr.appendChild(newTd);
  newTbody.appendChild(newTr);
	
  newTable.appendChild(newTbody);
  return newTable;
}



function createOptions() {
  var newDiv=document.createElement("div");
  var newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','OPTIONS');
  newButton.setAttribute('onclick','showOptions()');
  newButton.appendChild(document.createTextNode("Add & Remove Candidates"));
  newButton.appendChild(document.createElement("br"));
  newButton.appendChild(document.createTextNode("and other options"));
  newDiv.appendChild(newButton);
  return newDiv;
}


function createVoting() {
  var newDiv=document.createElement("div");
  newDiv.setAttribute('id','votingDiv');
  var newTable=document.createElement("table");
  newTable.setAttribute('class','structure');
  newTable.setAttribute('cellpadding','0');
  newTable.setAttribute('cellspacing','20');
  var newTbody=document.createElement("tbody");
  var newTr=document.createElement("tr");
  newTr.setAttribute('valign','top');
  var newTd=document.createElement("td");
  //newTd.setAttribute('vertical-align','middle');
  newTd.appendChild(createRankTable());
  newTr.appendChild(newTd);
  newTd=document.createElement("td");
  newTd.appendChild(createRankButtons());
  newTr.appendChild(newTd);
  newTd=document.createElement("td");
  newTd.appendChild(createMatrix());
  newTr.appendChild(newTd);
  newTbody.appendChild(newTr);
  newTable.appendChild(newTbody);
  newDiv.appendChild(newTable);
  newDiv.appendChild(createOptions());
  newDiv.appendChild(createSummation());

  getObj("mainDiv").appendChild(newDiv);

  updateRankTable();
}


function createAddVotes() {
  var newP=document.createElement("p");
  var newLabel=document.createElement("label");
  newLabel.appendChild(document.createTextNode("Number of votes to add"));
  newP.appendChild(newLabel);
  newP.appendChild(document.createElement("br"));

  var newInput=document.createElement("input");
  newInput.setAttribute('id','nrOfVotes');
  newInput.setAttribute('type','text');
  newInput.setAttribute('size','5');
  newInput.setAttribute('maxlength','10'); //10^10 votes at a time...
  newInput.setAttribute('align','right');
  newInput.setAttribute('onFocus','this.select()');
  newInput.setAttribute('value','1');;
  newP.appendChild(newInput);
  var newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','ADDVOTES');
  newButton.setAttribute('onclick','addVotes()');
  newButton.appendChild(document.createTextNode("Add Votes"));
  newP.appendChild(newButton);
  return newP;
}


function addVotes() {
  //  alert("quak");
  for (var x=0; x<Rank.length; x++)
    for (var y=0; y<x; y++) {
      sumMatrix[x][y]=sumMatrix[x][y]+Number(getObj("nrOfVotes").value)*Number(getObj(x+","+y).firstChild.data);
      getObj("s"+x+","+y).firstChild.data=sumMatrix[x][y];
      sumMatrix[y][x]=sumMatrix[y][x]+Number(getObj("nrOfVotes").value)*Number(getObj(y+","+x).firstChild.data);
      getObj("s"+y+","+x).firstChild.data=sumMatrix[y][x];
    }	
}




function createSummationMatrix() {
	
  var newDiv=document.createElement("div");
	
  var newTable=document.createElement("table");
  newTable.setAttribute('id','summationMatrix');
	
  var tHead=document.createElement("thead");
	
  //first row
  var newTr=document.createElement("tr");
	
  var newTh=document.createElement("th");
  newTr.appendChild(newTh);

  for (var x=0;x<Rank.length;x++) {
    newTh=document.createElement("th");
    newTh.setAttribute('id','colHead'+x);
    newTh.setAttribute('align','center');
    newTh.setAttribute('width','20');//FIXME - unflexibel
    var newB=document.createElement("b");
    newB.appendChild(document.createTextNode(unescape("%"+(x+41))));
    newTh.appendChild(newB);
    newTr.appendChild(newTh);
  }
  tHead.appendChild(newTr);
  newTable.appendChild(tHead);

  var tBody=document.createElement("tbody");

  //main part
  for (var y=0;y<Rank.length;y++) {
    newTr=document.createElement("tr");	  

    var newTd=document.createElement("td");
    newTd.setAttribute('id','rowHead'+y);
    var newB=document.createElement("b");
    newB.appendChild(document.createTextNode(Candidates[y]+" ("+unescape("%"+(y+41))+")"));
    newTd.appendChild(newB);
    newTr.appendChild(newTd);

    for (var x=0;x<Rank.length;x++) {
      var newTd=document.createElement("td");
      newTd.setAttribute('id',"s"+x+","+y);
      if (x==y) newTd.appendChild(document.createTextNode("-"));
      else {
	newTd.appendChild(document.createTextNode(sumMatrix[x][y]));
	//newTd.setAttribute("onMouseover","highlightHeaders("+"+x+","+y+");");
	//newTd.setAttribute("onMouseout","unHighlightHeaders("+x+","+y+");");
      }
      newTd.setAttribute('align','center');

      newTr.appendChild(newTd);
    }
    tBody.appendChild(newTr);
	
  }

  newTable.appendChild(tBody);
  newDiv.appendChild(newTable);
  /*
    newFieldLegend=document.createElement("p");
    newFieldLegend.setAttribute('id','fieldLegend');
    newFieldLegend.appendChild(document.createTextNode(""));
    newFieldLegend.appendChild(document.createElement("br"));
	
    newDiv.appendChild(newFieldLegend);
  */
	

  return newDiv;
}



function createSummation() {
  var newDiv=document.createElement("div");
  newDiv.setAttribute('id','summationDiv');
  newDiv.appendChild(document.createElement("hr"));
  var newP=document.createElement("h2");
  newP.appendChild(document.createTextNode("Summated Matrix"));
  newDiv.appendChild(newP);
  var newTable=document.createElement("table");
  newTable.setAttribute('class','structure');
  newTable.setAttribute('cellpadding','20');
  newTable.setAttribute('cellspacing','0');
  var newTbody=document.createElement("tbody");
  var newTr=document.createElement("tr");
  newTr.setAttribute('valign','top');
  var newTd=document.createElement("td");
  //newTd.setAttribute('vertical-align','middle');

  newTd.appendChild(createAddVotes());
  newTr.appendChild(newTd);
  newTd=document.createElement("td");
  newTd.appendChild(createSummationMatrix());
  newTr.appendChild(newTd);
  newTbody.appendChild(newTr);
  newTable.appendChild(newTbody);
  newDiv.appendChild(newTable);

  var newButton=document.createElement("button");
  newButton.setAttribute('type','button');
  //  newButton.setAttribute('value','EVALUTATE');
  newButton.setAttribute('onclick','evaluateSum()');
  newButton.appendChild(document.createTextNode("Evalutation"));

  newDiv.appendChild(newButton);

  return newDiv;
}



function evaluateSum(){
  if (eval) getObj("summationDiv").removeChild(getObj("evalDiv"));
  else eval=true;

  var newDiv=document.createElement("div");
  newDiv.setAttribute("id","evalDiv");
  newDiv.appendChild(document.createElement("hr"));
  var newH=document.createElement("h2");
  newH.appendChild(document.createTextNode("Evaluation"));
  newDiv.appendChild(newH);

  var n=Rank.length;

  var p=new Array(n);
  for (var i=0; i<n; i++) {
    p[i]=new Array(n);
    for (var j=0; j<n; j++)
      if (i!=j) p[i][j]=sumMatrix[j][i]-sumMatrix[i][j];
  }

  for (var i=0; i<n; i++)
    for (var j=0; j<n; j++)
      if (i!=j)
	for (var k=0; k<n; k++)
	  if ((i!=k)&&(j!=k)) {
	    var s=Math.min(p[j][i],p[i][k]);
	    if (p[j][k]<s) p[j][k]=s;
	  }

  var w=new Array(n);
  for (var i=0; i<n; i++) {
    w[i]=true;
    for (var j=0; j<n; j++)
      if (i!=j)
	if (p[j][i]>p[i][j])
	  w[i]=false;
  }
  
  newDiv.appendChild(document.createTextNode("Winner: "));
  for (var i=0; i<n; i++)
    if (w[i]) newDiv.appendChild(document.createTextNode(Candidates[i]+" "));

  newDiv.appendChild(document.createElement("br"));
  newDiv.appendChild(document.createElement("br"));
  newDiv.appendChild(document.createElement("br"));
  newDiv.appendChild(document.createTextNode("This evalutation uses Markus Schulzes implementation of the Schulze Method -"));
  newDiv.appendChild(document.createElement("br"));
  newDiv.appendChild(document.createTextNode("see "));
  var newA=document.createElement("a");
  newA.setAttribute('href','schulze.pdf');
  newA.appendChild(document.createTextNode("VOTING MATTERS, issue 17, page 9-19, October 2003"));
  newDiv.appendChild(newA);
  newDiv.appendChild(document.createTextNode(" (page 6)"));

  getObj("summationDiv").appendChild(newDiv);
}



function resetRankTable() {
  Rank.splice(0,Rank.length); 
  for (var i=0;i<Candidates.length;i++) Rank.push(1);
  lastRank=1;
}

function resetAll() {
  resetRankTable();
  sumMatrix.splice(0,Rank.length);
  for (var i=0;i<Rank.length;i++){
    sumMatrix[i]=new Array(Rank.length);
    for (var j=0; j<Rank.length;j++) {
      sumMatrix[i][j]=0;
    }
  }
}



function buildSite() {
  Candidates = new Array("Fischer","Schr"+unescape('%F6')+"der","Stoiber","Westerwelle","Gysi","Str"+unescape('%F6')+"bele","Merkel");

  //Candidates = new Array("Physik","Informatik","Heilpaedagogik","Gender Studies","Soziologie","Politikwissenschaft","Biologie","Jura","Medizin","BWL","VWL","Volkskunde / Kulturwissenschaften","Ethnologie","Philosophie","Sozialpaedagogik","Chemie","Pharmazie","Geschichte","Mathematik","Mikrosystemtechnik","Englisch","Germanistik","Franzoesisch","Geographie","Oekologie","Geologie","Architektur","Musik","Kunst","\"Medien\"","Sport","Theologie","Maschinenbau","Ernaehrungswissenschaften","Meteorologie","Forstwissenschaft");
  Rank=new Array(); 
  sumMatrix=new Array(Rank.length);

  loseValue=0;
  remisValue=1;
  winValue=2;

  resetAll();

  v=false;
  c=false;

  eval=false;
	
  var title=document.createElement("h1");
  title.appendChild(document.createTextNode("Condorcet Voting Simulation"));
  getObj("body").appendChild(title);


  var mainDiv=document.createElement("div");
  mainDiv.setAttribute('id','mainDiv');
	
  getObj("body").appendChild(mainDiv);
  mainDiv.appendChild(document.createElement("hr"));
  createVoting();

  //mainDiv.appendChild(createSummation());

  var newDiv=document.createElement("div");
  newDiv.appendChild(document.createElement("br"));
  newDiv.appendChild(document.createElement("hr"));
  newDiv.appendChild(document.createTextNode("Written by "));
  newA=document.createElement("a");
  newA.setAttribute('href','mailto:nicodietrich@web.de');
  newA.appendChild(document.createTextNode("Nicolas Dietrich"));
  newDiv.appendChild(newA);
  newDiv.appendChild(document.createElement("br"));
  newDiv.appendChild(document.createTextNode("Last modified: "+document.lastModified));

  getObj("body").appendChild(newDiv);
}


buildSite();
