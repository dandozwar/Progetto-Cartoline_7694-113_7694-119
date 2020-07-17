/* This document contains data on Codifica di Testi.
	Filename: script.js
	Author: Alessandro Cignoni matricola 561497
	Date: 17/07/2020
*/

// FUNZIONI
function cambia_da_cartolina(id_cartolina) {
	var altra_cartolina, questa_cartolina;
	if (id_cartolina == "c7694-113") {
		altra_cartolina = document.getElementById("c7694-119");
		questa_cartolina = document.getElementById("c7694-113");
	} else if (id_cartolina == "c7694-119") {
		altra_cartolina = document.getElementById("c7694-113");
		questa_cartolina = document.getElementById("c7694-119");
	};
	altra_cartolina.removeAttribute("hidden");
	questa_cartolina.removeAttribute("hidden");
	questa_cartolina.setAttribute("hidden", "hidden");
};

function cambia_edizione() {
	var tags_altri, tags_questi;
	if (edizione == 'diplomatica') {
		tags_questi = document.getElementsByClassName('diplomatica');
		tags_altri = document.getElementsByClassName('interpretativa');
		document.getElementById('bottone_edizioni').innerText = "Passa all'edizione interpretativa";
		edizione = 'interpretativa';
	} else if (edizione == 'interpretativa') {
		tags_questi = document.getElementsByClassName('interpretativa');
		tags_altri = document.getElementsByClassName('diplomatica');
		document.getElementById('bottone_edizioni').innerText = "Passa all'edizione diplomatica";
		edizione = 'diplomatica';
	};
	for (var t = 0; t < tags_questi.length; t++) {
		tags_questi[t].removeAttribute("hidden");
	};
	for (var t = 0; t < tags_altri.length; t++) {
		tags_altri[t].removeAttribute("hidden");
		tags_altri[t].setAttribute("hidden", "hidden");
	};
};

function mouse_sul_testo(id) {
	var id_zona = id.slice(0, id.length - 5) + '_zona';
	var prec_style = 	document.getElementById(id_zona).style.cssText;
	document.getElementById(id_zona).style.cssText = prec_style + "background: rgba(255, 0, 0, 0.3);";
};

function mouse_sulla_cartolina(id) {
	var id_riga = id.slice(0, id.length - 5) + '_riga';
	var prec_style = 	document.getElementById(id_riga).style.cssText;
	document.getElementById(id_riga).style.cssText = prec_style + "background: rgba(255, 255, 0, 0.3);";
};

function mouse_via_testo(id) {
	var id_zona = id.slice(0, id.length - 5) + '_zona';
	var prec_style = document.getElementById(id_zona).style.cssText;
	var new_style = prec_style.replace('rgba(255, 0, 0, 0.3)', 'transparent');
	document.getElementById(id_zona).style.cssText = new_style;
};

function mouse_via_cartolina(id) {
	var id_riga = id.slice(0, id.length - 5) + '_riga';
	var prec_style = 	document.getElementById(id_riga).style.cssText;
	var new_style = prec_style.replace('rgba(255, 255, 0, 0.3)', 'transparent');
	document.getElementById(id_riga).style.cssText = new_style;
};

// AZIONI ALL'AVVIO DEL FILE
function funzione_avvio() {
	cambia_da_cartolina("c7694-119");
	cambia_edizione();
};

var edizione = 'diplomatica';
window.onload = funzione_avvio;
