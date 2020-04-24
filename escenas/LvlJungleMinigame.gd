extends Node
var Palabra = "";
var datosCuriosos = [
"Las suturas trenzadas pueden albergar más bacterias en sus intersticios, que las suturas monofilamentosas.",
"Las suturas absorbibles son excelentes para suturar tejido subcutáneo en niños, ya que no requiere retirarse.",
"Las suturas multifilamentosas poseen mayor capilaridad por lo que no se recomienda en presencia de contaminación.",
"El acero quirúrgico no debe usarse con prótesis de otra aleación porque puede pueden ocurrir reacciones electrolíticas.",
"El poliéster está recubierto por polibutilato compuesto inerte que facilita el paso por los tejidos, excelente flexibilidad, manejo y anudado uniforme.",
"Las suturas continuas pueden transmitir infecciones a lo largo de la hebra, por lo que se prefiere utilizar un material monofilamentoso para evitarlo."
];
var PalabrasAcertadas = [];
var Acerts = ["VBoxContainer/HBoxContainer/Btn_1",
"VBoxContainer/HBoxContainer/Btn_2",
"VBoxContainer/HBoxContainer/Btn_3",
"VBoxContainer/HBoxContainer/Btn_4",
"VBoxContainer/HBoxContainer/Btn_5",
"VBoxContainer/HBoxContainer/Btn_6",
"VBoxContainer/HBoxContainer/Btn_7",
"VBoxContainer/HBoxContainer/Btn_8",
"VBoxContainer/HBoxContainer/Btn_9",
"VBoxContainer/HBoxContainer/Btn_10",
"VBoxContainer/HBoxContainer/Btn_11"]

var Contenedor = ["VBoxContainer/GridContainer/Ctner-Ub/Ltr_1",
"VBoxContainer//GridContainer/Ctner-Ub2/Ltr_2",
"VBoxContainer/GridContainer/Ctner-Ub3/Ltr_3",
"VBoxContainer/GridContainer/Ctner-Ub4/Ltr_4",
"VBoxContainer/GridContainer/Ctner-Ub5/Ltr_5",
"VBoxContainer/GridContainer/Ctner-Ub6/Ltr_6",
"VBoxContainer/GridContainer/Ctner-Ub7/Ltr_7",
"VBoxContainer/GridContainer/Ctner-Ub8/Ltr_8",
"VBoxContainer/GridContainer/Ctner-Ub9/Ltr_9",
"VBoxContainer/GridContainer/Ctner-Ub10/Ltr_10",
"VBoxContainer/GridContainer/Ctner-Ub11/Ltr_11",
"VBoxContainer/GridContainer/Ctner-Ub12/Ltr_12",
"VBoxContainer/GridContainer/Ctner-Ub13/Ltr_13",
"VBoxContainer/GridContainer/Ctner-Ub14/Ltr_14"]

var Dataset = ["NYLON","OXANONA","CROMADO","POLIESTER","POLIGLACTIN","PROPILENO","QUIRURGICO","TRENZADA"]

#BIBLIOGRAFIA

var infoPopup = [{#https://www.worldwildlife.org/descubre-wwf/historias/donde-y-como-viven-los-tigres
	"Nombre"  : "NYLON",
	"NombreSC": "NYLON",
},{#http://catalogo.biodiversidad.co/file/56d44e983c16479905cba87c/details
	"Nombre"  : "OXANONA",
	"NombreSC": "POLIDIOXANONA"
},{#http://www.cocodrilopedia.com
	"Nombre"  : "CROMADO",
	"NombreSC": "CATGUT CROMADO"
},{#https://www.planetacurioso.com/2018/07/30/15-datos-curiosos-que-no-sabias-sobre-las-serpientes/
	"Nombre"  : "POLIESTER",
	"NombreSC": "POLIESTER"
},{#https://avesexoticas.org/loros/;http://www.librediariodigital.net/texto-diario/mostrar/1281475/6-curiosidades-sobre-loros
	"Nombre"  : "POLIGLACTIN",
	"NombreSC": "POLIGLACTIN 910"
},{#https://arbolabc.com/imagenes-de-animales/saltamontes
	"Nombre"  : "PROPILENO",
	"NombreSC": "POLIPROPILENO"
},{#https://animapedia.org/animales-aereos/garza/
	"Nombre"  : "QUIRURGICO",
	"NombreSC": "ACERO QUIRURGICO"
},{#https://animapedia.org/animales-aereos/garza/
	"Nombre"  : "TRENZADA",
	"NombreSC": "SEDA NEGRA TRENZADA"
}]
var datoMostrado = false 
func _ready():
	if(!datoMostrado):
		var rng = RandomNumberGenerator.new()
		var datoCuriosoShufled = shuffleList(datosCuriosos)
		$datoCurioso/texto.text = datoCuriosoShufled[rng.randi()%datoCuriosoShufled.size()]
		$datoCurioso.popup()
	
	if(datoMostrado):
		$Temporizador/Timer.start()
	else:
		$Temporizador/Timer.stop()
	
	var nodo = get_node("Lbel_Nivel");
	nodo.text = "Level\n"+str(PalabrasAcertadas.size()+1);
	Dataset = shuffleList(Dataset)
	if (Dataset.size() != 0):
		Palabra = Dataset[randi()%Dataset.size()];
		_crear_letras();
	else:
		$GameFinish.popup()

func get_animal_image():
	var Img = load("res://imagenes/"+Palabra+".png");
	return Img;

func _crear_letras():
	var Image_2 = get_node("TextureRect");
	Image_2.texture = get_animal_image();
	
	var ABC = shuffleList(["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"])
	var i = 0;
	var cont = shuffleList(Contenedor)
	for letter in Palabra:
		var nodo_2 = get_node(Acerts[i]);
		var nodo = get_node(cont[i]);
		nodo.text = letter; 
		nodo.visible = true;
		nodo_2.visible = true;
		i = i+1;
	
	var rng = RandomNumberGenerator.new()
	for d in range(i,14):
		rng.randomize();
		var node = get_node(cont[d]);
		node.text = ABC[rng.randi()%ABC.size()];
		node.visible = true;

func shuffleList(list):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var shuffledList = [] 
	var indexList = range(list.size())
# warning-ignore:unused_variable
	for i in range(list.size()):
       	var x = rng.randi()%indexList.size()
       	shuffledList.append(list[indexList[x]])
       	indexList.remove(x)
	return shuffledList

func AgregarPalabra(letter):
	var i = 0;
	var bandera = true;
	while( bandera == true ):
		var nodo = get_node(Acerts[i]);
		if(nodo.text == "_"):
			nodo.text = letter;
			bandera = false
		else:
			i = i+1
		
		if(i == Palabra.length()):
			bandera = false
	PalabraCorrecta()

func clear():
	var i = 0;
# warning-ignore:unused_variable
	for b in range(Acerts.size()):
		var btn = get_node(Acerts[i]);
		btn.text = "_";
		btn.visible = false;
		i= i + 1;

func PalabraCorrecta():
	var PalabraAcertada = "";
	var i = 0;
	for b in Palabra:
		var btn = get_node(Acerts[i]);
		PalabraAcertada = PalabraAcertada + btn.text;
		i=i+1
	
	if(Palabra == PalabraAcertada):
		var position = null;
		for x in range(Dataset.size()):
			if(Palabra == Dataset[x]):
				position = x;
				PalabrasAcertadas.append(Dataset[x]);
		Dataset.remove(position);
		_popup_message()

func _click_buttons(n):
	var number = n - 1; 
	get_node(Contenedor[number]).visible = false
	AgregarPalabra(get_node(Contenedor[number]).text);

func _popup_message():
	$Temporizador/Timer.stop()
	var rng = RandomNumberGenerator.new()
	for Animal in infoPopup:
		if(Animal.Nombre == Palabra):
			rng.randomize()
			$LvlMessage/AnimalTitles/Nombre.text = Animal.Nombre
			$LvlMessage/AnimalTitles/NombreSC.text = Animal.NombreSC
	$LvlMessage.popup()

func _on_Ltr_1_pressed():
	_click_buttons(1);

func _on_Ltr_2_pressed():
	_click_buttons(2);

func _on_Ltr_3_pressed():
	_click_buttons(3);

func _on_Ltr_4_pressed():
	_click_buttons(4);

func _on_Ltr_5_pressed():
	_click_buttons(5);

func _on_Ltr_6_pressed():
	_click_buttons(6);

func _on_Ltr_7_pressed():
	_click_buttons(7);

#Inferior

func _on_Ltr_8_pressed():
	_click_buttons(8);

func _on_Ltr_9_pressed():
	_click_buttons(9);

func _on_Ltr_10_pressed():
	_click_buttons(10);

func _on_Ltr_11_pressed():
	_click_buttons(11);

func _on_Ltr_12_pressed():
	_click_buttons(12);

func _on_Ltr_13_pressed():
	_click_buttons(13);

func _on_Ltr_14_pressed():
	_click_buttons(14);

func _on_Btn_Continuar_pressed():
	$LvlMessage.hide()
	$Temporizador.DisplayValue = 61
	clear()
	_ready()


func _on_TextureButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://escenas/MinigameDos.tscn");



func _on_Clear_pressed():
	var i = 0;
# warning-ignore:unused_variable
	for b in range(Acerts.size()):
		var btn = get_node(Acerts[i]);
		if(btn.visible == true):
			btn.text = "_";
		i= i + 1;
	i = 0
# warning-ignore:unused_variable
	for b in range(Contenedor.size()):
			var btn = get_node(Contenedor[i]);
			btn.visible = true;
			i = i + 1

func _Game_Over():
	$TimerFinish.popup();

func _on_BtnGameOver_pressed():
	_on_TextureButton_pressed()


func _on_cerrarDatoCurioso_pressed():
	datoMostrado = true;
	$Temporizador/Timer.start()
	$datoCurioso.hide()