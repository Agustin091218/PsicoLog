puts "=== Creando usuarios profesionales ==="

axel = User.find_or_create_by!(email: "axel@psicolog.com") do |u|
  u.first_name = "Axel"
  u.last_name = "Mrak"
  u.phone = "2615550101"
  u.password = "password123"
end
puts "  ✓ #{axel.full_name} (#{axel.email})"

julian = User.find_or_create_by!(email: "julian@psicolog.com") do |u|
  u.first_name = "Julián"
  u.last_name = "Fernández"
  u.phone = "2615550202"
  u.password = "password123"
end
puts "  ✓ #{julian.full_name} (#{julian.email})"

andres = User.find_or_create_by!(email: "andres@psicolog.com") do |u|
  u.first_name = "Andrés"
  u.last_name = "Giménez"
  u.phone = "2615550303"
  u.password = "password123"
end
puts "  ✓ #{andres.full_name} (#{andres.email})"

puts ""
puts "=== Creando pacientes ==="

def create_patient(user, first_name, last_name)
  Patient.find_or_create_by!(user: user, first_name: first_name, last_name: last_name)
end

# Pacientes de Axel
axel_patients = [
  create_patient(axel, "Martín", "González"),
  create_patient(axel, "Camila", "Rodríguez"),
  create_patient(axel, "Luciana", "Sosa"),
  create_patient(axel, "Federico", "Pérez"),
  create_patient(axel, "Valentina", "Díaz")
]
puts "  ✓ #{axel.full_name}: #{axel_patients.size} pacientes"

# Pacientes de Julián
julian_patients = [
  create_patient(julian, "Santiago", "López"),
  create_patient(julian, "Florencia", "Martínez"),
  create_patient(julian, "Joaquín", "Romero"),
  create_patient(julian, "Agustina", "Torres")
]
puts "  ✓ #{julian.full_name}: #{julian_patients.size} pacientes"

# Pacientes de Andrés
andres_patients = [
  create_patient(andres, "Bautista", "Álvarez"),
  create_patient(andres, "Catalina", "Benítez"),
  create_patient(andres, "Mateo", "Ferreyra")
]
puts "  ✓ #{andres.full_name}: #{andres_patients.size} pacientes"

puts ""
puts "=== Creando notas ==="

def create_note(patient, type, date, content)
  Note.find_or_create_by!(patient: patient, note_type: type, recorded_at: date) do |n|
    n.content = content
  end
end

# ─── AXEL ───

# Martín González (sesión inicial → seguimiento)
create_note(axel_patients[0], "initial_interview", 20.days.ago,
  "Primera entrevista con Martín. Viene derivado por el colegio por bajo rendimiento. Refiere dificultades para concentrarse en clase y " +
  "se duerme en horario escolar. En casa dice que pasa mucho tiempo con el celular de noche. Los padres están separados hace 2 años y " +
  "la madre nota que desde entonces está más retraído. No hay antecedentes de tratamiento psicológico previo.\n\n" +
  "Se lo ve colaborador pero algo ansioso, se toca el pulgar constantemente. Habla en tono bajo. Le cuesta sostener la mirada.\n\n" +
  "Acordamos frecuencia semanal por ahora. Vamos a trabajar en hábitos de sueño e indagar más sobre la dinámica familiar.")

create_note(axel_patients[0], "session_note", 14.days.ago,
  "Hoy llegó más suelto, incluso sonrió un par de veces. Me contó que bajó el uso del celu a la noche después de lo que hablamos, " +
  "que su mamá le compró un despertador y deja el teléfono en el living. Dice que se está durmiendo más temprano pero que todavía " +
  "le cuesta levantarse.\n\n" +
  "Hablamos bastante del tema de la separación de los padres. Dice que no lo afecta pero cuando le pregunto por los fines de semana " +
  "se pone tenso. Cambia de tema rápido.\n\n" +
  "Le dejé de tarea anotar qué cosas le gustaría que cambien en casa, sin filtro.")

create_note(axel_patients[0], "session_note", 7.days.ago,
  "Trajo la lista. Anotó 4 cosas: que la mamá no hable mal del papá, que el papá lo pase a buscar puntual, " +
  "que no lo obliguen a elegir con quién pasar las fiestas y que le compren una bici. Fuimos charlando punto por punto.\n\n" +
  "Lo de las fiestas lo tiene muy angustiado. El año pasado terminó llorando en Navidad porque la mamá le hizo un escándalo al papá " +
  "en la puerta. Laburamos eso con silla vacía. Estuvo fuerte, se quebró un poco, pero después dijo que se sintió aliviado.\n\n" +
  "Quedamos en que para la próxima quiere invitar a la mamá a una sesión conjunta para hablar de las fiestas.")

create_note(axel_patients[0], "quick_note", 3.days.ago,
  "Me mandó un audio la mamá diciendo que Martín tuvo una discusión fuerte con el papá por teléfono y después se encerró en la pieza. " +
  "Lo llamé para ver cómo estaba. Me dijo que el papá le dijo que no iba a poder pasar a buscarlo este finde porque se iba con la " +
  "novia a Córdoba. Estaba enojado, no triste. Le dije que era esperable el enojo y que era sano que lo exprese. " +
  "Quedamos en charlarlo en la sesión del miércoles. Le mandé un mensaje a la mamá avisando que hablé con él.")

# Camila Rodríguez (ansiedad)
create_note(camila_patient = axel_patients[1], "initial_interview", 18.days.ago,
  "Camila tiene 24 años, viene por ataques de ansiedad. El primero fue hace 3 meses en el trabajo, " +
  "estaba en una reunión y sintió que se ahogaba, taquicardia, pensó que se moría. Desde entonces tuvo 4 episodios más.\n\n" +
  "Trabaja en una agencia de marketing y dice que el ambiente es bastante tóxico, con fechas límite imposibles. " +
  "Su jefa le cambia las prioridades constantemente. Está pensando en renunciar pero tiene miedo de no conseguir otra cosa.\n\n" +
  "Vive sola, tiene un gato que se llama Simón. No está en pareja. Tiene pocos amigos y dice que casi no sale porque está siempre " +
  "cansada. Los fines de semana duerme hasta el mediodía.\n\n" +
  "Hicimos un ejercicio de respiración diafragmática y lo pudo hacer bien. Se fue más tranquila que como llegó.")

create_note(camila_patient, "session_note", 11.days.ago,
  "Tuvo un ataque de ansiedad el martes en el subte. Usó la respiración que practicamos y dice que ayudó pero igual se bajó " +
  "antes de su estación. Está frustrada, siente que no avanza.\n\n" +
  "Charlamos sobre el perfeccionismo. Es muy exigente consigo misma, se castiga por cosas que a otras personas ni les importan. " +
  "Me contó que de chica sus viejos le festejaban los 10 pero no el 8. Recién ahora lo está conectando.\n\n" +
  "Le propuse que esta semana registre pensamientos automáticos con el modelo ABC que vimos. " +
  "También hablamos de poner límites en el laburo, cosas chicas primero: no contestar mails después de las 20hs.")

create_note(camila_patient, "session_note", 4.days.ago,
  "Arrancó la sesión diciendo 'soy una idiota'. Le pregunté por qué y me dijo que ayer contestó mails a las 22hs. " +
  "Trabajamos la autocompasión, le costó mucho. Se ríe cuando intenta hablarse con cariño.\n\n" +
  "Trajo el registro ABC — anotó 3 situaciones y pudo identificar pensamientos irracionales. Hay uno recurrente: " +
  "'si no hago todo perfecto me van a echar'. Le planteé que busque evidencia objetiva de eso y no encontró ninguna.\n\n" +
  "Hablamos de tomarse días de vacaciones. Hace 2 años que no se toma ni un viernes. " +
  "Quedó en pedir un día en el laburo antes de la próxima sesión.")

create_note(camila_patient, "general_note", 2.days.ago,
  "Me mandó un mensaje diciendo que pidió el viernes libre y se lo dieron sin problema. " +
  "Estaba shockeada de que fuera tan fácil. Me contó que se armó un plan de ir a la reserva ecológica, " +
  "compró facturas para el desayuno y se llevó un libro. Le mandé un audio felicitándola.")

# Luciana Sosa (etapa vital, crisis de los 30)
create_note(axel_patients[2], "initial_interview", 25.days.ago,
  "Luciana tiene 32 años, médica clínica. Viene porque siente que 'está viviendo la vida que otros quieren para ella'. " +
  "Se recibió a los 25, hizo la residencia, entró a un sanatorio privado y ahora está estable pero infeliz.\n\n" +
  "Está en pareja con Juan hace 6 años, conviven hace 3. Dice que lo quiere pero que ya no siente lo mismo, " +
  "y se siente culpable por eso. Juan quiere casarse y tener hijos, ella no sabe. Cada vez que tocan el tema discuten.\n\n" +
  "Tiene un grupo de amigas del colegio que la critican por todo, siente que no puede ser ella misma. " +
  "Le pregunté qué haría si no tuviera miedo y dijo 'irme a vivir a Córdoba y poner un consultorio chico en las sierras'. " +
  "Se sorprendió de su propia respuesta.\n\n" +
  "Vamos a laburar el autoconocimiento. Que pueda escucharse sin el ruido de afuera.")

create_note(axel_patients[2], "session_note", 18.days.ago,
  "Hizo una lista de cosas que le gustan y no le gustan de su vida actual. El 70% de 'no me gusta' era cosas que hace por los demás. " +
  "Le costó identificar qué le gusta genuinamente, dice que no lo piensa hace años.\n\n" +
  "Hablamos de la culpa. Siente que si deja a Juan es una mala persona, que si cambia de laburo es una desagradecida. " +
  "Trabajamos con preguntas socráticas: ¿quién define lo que está bien? ¿qué es lo justo para vos?\n\n" +
  "La sesión fue movilizante. Lloró varias veces pero dijo que era un alivio. " +
  "Tarea para la próxima: imaginar un domingo ideal sin expectativas ajenas y describirlo.")

create_note(axel_patients[2], "session_note", 11.days.ago,
  "Trajo el domingo ideal: despertarse sin alarma, desayunar en el patio, salir a andar en bici, cocinar pastas a la noche. " +
  "Dijo que lloró cuando lo escribió porque se dio cuenta de que no hace NADA de eso.\n\n" +
  "Hablamos de Juan. Este finde tuvieron una charla larga y ella pudo decirle que no quiere casarse todavía. " +
  "Juan lo tomó mejor de lo que ella esperaba. Le dijo que la espera, que no tiene apuro. Ella se quedó con la sensación " +
  "de que igual no la entiende del todo.\n\n" +
  "También hablamos del laburo. Está considerando reducir las horas en el sanatorio y empezar a atender en un consultorio " +
  "compartido con una colega. Tiene miedo del qué dirán sus jefes. La animé a que lo piense como un experimento, no un cambio definitivo.")

# ─── JULIÁN ───

# Santiago López (depresión)
create_note(julian_patients[0], "initial_interview", 22.days.ago,
  "Santiago tiene 19 años, está cursando el primer año de Ingeniería. Viene porque se siente vacío, sin motivación. " +
  "Dice que todo le da igual, que no disfruta nada. Duerme mal, come mal, se aisló de sus amigos.\n\n" +
  "No hay un evento gatillo claro. Fue progresivo. Empezó a mitad del secundario, se acentuó en la pandemia y ahora en la facu " +
  "explotó. Faltó a los últimos 3 parciales porque no podía levantarse de la cama.\n\n" +
  "Vive con los padres y una hermana menor. Dice que en su casa no se habla de emociones, 'son todos ingenieros, " +
  "no entienden estas cosas'. El papá piensa que es vago. Le recomendé empezar a registrar cómo se siente día a día, sin presiones.")

create_note(julian_patients[0], "session_note", 15.days.ago,
  "No hizo el registro. Me dijo 'no tuve ganas' y se encogió de hombros. No lo reté, le pregunté cómo se sintió la semana. " +
  "Dijo que igual, que no pasó nada.\n\n" +
  "Le propuse hacer el registro juntos en sesión. Fuimos día por día de la semana pasada. " +
  "Pudo identificar que el miércoles se sintió 'menos peor' porque fue a jugar a la pelota con un amigo del barrio. " +
  "El jueves y viernes no salió de la cama.\n\n" +
  "Hablamos de cosas chiquitas que antes le gustaban. Mencionó andar en skate. Le pregunté si se animaba a sacar la tabla " +
  "del galpón esta semana, aunque sea mirarla. Dijo 'puede ser'.")

create_note(julian_patients[0], "session_note", 8.days.ago,
  "Sacó la tabla. Estaba llena de polvo pero la limpió y salió a dar una vuelta a la plaza. " +
  "Me contó con un poco de brillo en los ojos. Dijo que se cayó dos veces pero que 'estuvo bueno'.\n\n" +
  "También hablamos de la hermana. La hermanita de 14 le preguntó por qué iba al psicólogo y él no supo qué responder. " +
  "Charlamos sobre qué cosas sí podría contarle — que a veces uno necesita ayuda para ordenar las ideas, " +
  "que no es nada grave pero ayuda.\n\n" +
  "Está evaluando recursar las materias que dejó en el segundo cuatrimestre. No le dije que sí ni que no, " +
  "solo le pregunté cómo se sentiría consigo mismo en cada caso.")

# Florencia Martínez (duelo)
create_note(julian_patients[1], "initial_interview", 30.days.ago,
  "Florencia tiene 41 años. Perdió a su mamá hace 4 meses, cáncer de páncreas, fue rápido. " +
  "Viene porque no puede parar de llorar y siente que ya tendría que estar mejor. Su papá falleció hace 8 años, " +
  "así que ahora se siente huérfana y eso la aterra.\n\n" +
  "Es hija única. Está casada con Pablo, tienen dos nenas de 7 y 10. Dice que trata de no llorar adelante de las chicas " +
  "pero que a veces no puede. Las nenas le preguntan cuándo va a volver la abuela.\n\n" +
  "Está de licencia en el trabajo hace 2 meses. Tiene miedo de que la echen, pero no se siente capaz de volver. " +
  "Validamos que 4 meses no es nada para un duelo. No hay tiempos. Lloró toda la sesión.")

create_note(julian_patients[1], "session_note", 23.days.ago,
  "Hoy vino un poco más entera. Me contó que esta semana pudo hablar con las nenas sobre la abuela sin llorar. " +
  "Les mostró fotos de cuando ella era chica con su mamá. Fue lindo, dice, pero agotador.\n\n" +
  "Salió el tema de la culpa. Siente que tendría que haber insistido más con los médicos, " +
  "que capaz si detectaban el cáncer antes se podía hacer algo. Trabajamos eso con reestructuración cognitiva: " +
  "no había síntomas previos, el equipo médico hizo todo lo posible, no hubo negligencia.\n\n" +
  "Le propuse escribirle una carta a su mamá. No para entregar, para ella. " +
  "Al principio se resistió pero después dijo que le parecía una buena idea.")

create_note(julian_patients[1], "session_note", 16.days.ago,
  "Trajo la carta. La leímos juntas en sesión. Era preciosa: le agradecía por enseñarle a cocinar, " +
  "por las vacaciones en Mar del Plata, por cómo la bancó cuando se separó de su primer novio. " +
  "Al final le decía que la extraña todos los días pero que va a estar bien.\n\n" +
  "Lloramos las dos. Después se quedó en silencio un rato largo y dijo 'necesitaba sacarlo'. " +
  "Le pregunté cómo se sentía y dijo 'más liviana, como si me hubiera sacado una mochila'.\n\n" +
  "Quedamos en que la próxima empezamos a pensar en la vuelta al trabajo, gradual, sin presiones.")

create_note(julian_patients[1], "follow_up", 7.days.ago,
  "Volvió al trabajo esta semana, media jornada. Dice que fue raro, que todos la miraban con cara de 'pobrecita' " +
  "y eso le molestó un poco. Pero se bancó las 4 horas.\n\n" +
  "Lo más difícil fue pasar por la oficina de la mamá — trabajaban en la misma empresa. " +
  "La primera vez que pasó se largó a llorar en el baño, pero dice que después se sintió mejor. Como que necesitaba " +
  "ese momento.\n\n" +
  "Hablamos de seguir con media jornada otra semana más. Está viendo si el médico le firma la continuidad. " +
  "Pablo la está bancando mucho, me dice que está agradecida. Evaluamos cómo está la pareja, dice que bien, " +
  "que esto los unió más.")

# Joaquín Romero (TOC)
create_note(julian_patients[2], "initial_interview", 19.days.ago,
  "Joaquín tiene 27 años, trabaja en sistemas. Viene por rituales de verificación que se le están yendo de las manos. " +
  "Arrancó en la pandemia con lavarse las manos seguido, después pasó a revisar 5 veces la puerta de entrada " +
  "y ahora está chequeando que las hornallas estén apagadas aunque no haya cocinado en todo el día.\n\n" +
  "Llega tarde al trabajo todos los días porque vuelve al departamento a revisar las llaves de gas. " +
  "Sus compañeros ya lo cargan. Él se ríe pero por dentro está desesperado.\n\n" +
  "Vive solo, tiene pocos vínculos, juega a la compu como evasión. La familia en San Juan, los ve poco. " +
  "No tuvo tratamiento previo. Es muy consciente de que sus rituales son irracionales pero no puede pararlos.\n\n" +
  "Vamos a empezar con psicoeducación sobre TOC y evaluación de la intensidad con una escala.")

create_note(julian_patients[2], "session_note", 12.days.ago,
  "Hicimos la escala Y-BOCS. Puntuó 24, rango moderado-grave. Las compulsiones más frecuentes son verificación " +
  "(gas, puerta, ventanas) y simetría (alinear las zapatillas, los libros, los cubiertos).\n\n" +
  "Empezamos a planificar la exposición con prevención de respuesta. Vamos de a poco. " +
  "Primera tarea: salir de casa sin revisar las ventanas. Solo la puerta y el gas.\n\n" +
  "Está ansioso solo de pensarlo. Le expliqué que la ansiedad va a subir pero después baja, como una ola. " +
  "Que es parte del proceso y que vamos a su ritmo. Se fue con cara de 'estás loco' pero aceptó el desafío.")

create_note(julian_patients[2], "emergency", 5.days.ago,
  "Me llamó a las 23hs diciendo que estaba en la puerta del depto hacía 40 minutos, no podía dejar de revisar. " +
  "Había ido y vuelto 8 veces. Estaba temblando, hiperventilando.\n\n" +
  "Lo guié por teléfono con respiración 4-7-8 hasta que se calmó. Después hicimos grounding 5-4-3-2-1. " +
  "Logró entrar al edificio. Le pedí que una vez adentro NO REVISARA NADA y se sirviera un vaso de agua.\n\n" +
  "Al rato me confirmó que estaba adentro, tomando agua y que no revisó. Chiquito pero enorme. " +
  "Mañana tenemos sesión extra para procesar esto.")

# ─── ANDRÉS ───

# Bautista Álvarez (adolescente, identidad)
create_note(andres_patients[0], "initial_interview", 21.days.ago,
  "Bautista tiene 16 años. Viene porque los padres lo encontraron con ropa de la hermana y no saben cómo manejarlo. " +
  "Bauti dice que no sabe si es gay, trans, o qué, pero que le gusta usar pollera y maquillarse a veces. " +
  "Lo charlamos a solas y fue bastante abierto.\n\n" +
  "Se siente juzgado en el colegio, los compañeros le dicen 'trolo' en los pasillos. Un par de amigos lo bancan. " +
  "En casa los padres están divididos: la mamá intenta entender, el papá directamente no habla del tema.\n\n" +
  "Es un pibe muy inteligente, sensible, le gusta dibujar y escribir. Me mostró unos poemas que escribe — " +
  "son muy buenos para su edad. Tiene una mirada muy madura de su propia situación.\n\n" +
  "Vamos a enfocarnos en que explore su identidad sin presiones, en un espacio seguro. Y laburar con los padres aparte " +
  "para ayudarlos a acompañar.")

create_note(andres_patients[0], "session_note", 14.days.ago,
  "Bauti llegó con pollera a sesión. Era la primera vez que salía a la calle así. Me dijo que se cambió en lo de un amigo " +
  "y después se vino. Estaba entre orgulloso y aterrado. Le pregunté cómo se sintió y dijo 'libre, pero con miedo'.\n\n" +
  "Hablamos del miedo. Concretamente: miedo a que lo caguen a palos, miedo a decepcionar a los viejos, " +
  "miedo a no saber quién es. Fuimos desarmando cada uno.\n\n" +
  "Sobre la identidad, le dije que no hay apuro, que se tome el tiempo de explorar sin etiquetas. " +
  "Él mismo dijo 'capaz no soy nada, solo me gusta la pollera'. Y está perfecto.\n\n" +
  "Me pidió si podía hablar con los viejos. Vamos a coordinar una sesión con ellos.")

create_note(andres_patients[0], "session_note", 7.days.ago,
  "Sesión con los padres. Vino la mamá, el papá no quiso. La madre está muy angustiada, " +
  "llora diciendo que no sabe qué hizo mal. Dediqué buena parte de la sesión a psicoeducar: " +
  "la identidad de género y la expresión de género no son algo que se 'provoque' ni que se 'arregle'.\n\n" +
  "Le pregunté qué es lo que más le preocupa y dijo que tiene miedo de que Bauti sufra, " +
  "que lo discriminen, que no consiga trabajo. Miedos válidos. Le dije que justamente por eso Bauti necesita " +
  "que ella sea su lugar seguro, no una fuente más de presión.\n\n" +
  "Al final dijo 'yo lo amo, es mi hijo, solo quiero que sea feliz'. Ahí está la punta del ovillo. " +
  "Vamos a seguir trabajando con ella aparte y tratar de sumar al papá en algún momento.")

# Catalina Benítez (trastorno alimentario)
create_note(andres_patients[1], "initial_interview", 24.days.ago,
  "Catalina tiene 22 años. Viene derivada por la nutricionista que detectó patrones restrictivos. " +
  "Mide 1.68 y pesa 43kg. No tiene diagnóstico previo de TCA pero la clínica es clara.\n\n" +
  "Empezó a restringir a los 17 después de que un compañero le dijo 'gorda' en una joda. " +
  "Desde entonces la relación con la comida es un campo de batalla. Cuenta calorías de todo, " +
  "incluso de la lechuga. Hace ayuno intermitente de 16 horas, a veces más.\n\n" +
  "Está en pareja con Tomás, que está muy preocupado. Fue él quien la convenció de pedir ayuda. " +
  "Catalina es muy inteligente, está en 4to año de Psicología — hay mucho insight pero poca autocompasión.\n\n" +
  "Vamos a trabajar con derivación a equipo interdisciplinario (nutri, clínica) y terapia individual.")

create_note(andres_patients[1], "session_note", 17.days.ago,
  "Tuvimos que parar la sesión 10 minutos porque se largó a llorar cuando le pregunté cuándo fue la última vez " +
  "que comió algo sin culpa. No se acordaba. Me dijo que capaz a los 12 años, en un cumpleaños de una amiga.\n\n" +
  "Reencuadramos: lo que ella hace no es 'disciplina', es un mecanismo que en su momento le sirvió para lidiar con el dolor " +
  "y ahora se le fue de las manos. No es su culpa, no es un fracaso moral.\n\n" +
  "Me dijo que el espejo le devuelve una imagen distinta a la que ven los demás. " +
  "Ella se ve gorda. Le mostré fotos suyas y le pregunté qué veía si la foto fuera de una amiga. " +
  "Dijo 'está muy flaca'. Todavía no puede aplicar esa mirada a sí misma.")

create_note(andres_patients[1], "follow_up", 3.days.ago,
  "Tuvo la primera consulta con la nutricionista que le recomendé. Le armó un plan de alimentación gradual, " +
  "con 4 comidas diarias y colaciones. Catalina dice que le pareció una banda de comida pero que la nutri le explicó " +
  "que es lo mínimo que necesita su cuerpo para funcionar.\n\n" +
  "Cumplió 3 de 7 días con las 4 comidas. Para ella es un montón. Está con náuseas y distensión — normal cuando el cuerpo " +
  "vuelve a recibir comida después de restricción. La médica clínica le pidió análisis, los esperamos para la próxima.\n\n" +
  "Hablamos de Tomás. Está siendo un sostén enorme pero Catalina se siente una carga. " +
  "Le planteé que en una pareja uno no es 'carga', se acompañan. Que si fuera al revés ella haría lo mismo.")

puts ""
puts "=== Semillas creadas ==="
puts ""
puts "  Usuarios:  Axel (axel@psicolog.com), Julián (julian@psicolog.com), Andrés (andres@psicolog.com)"
puts "  Contraseña: password123 (para todos)"
puts "  Total pacientes: #{Patient.count}"
puts "  Total notas: #{Note.count}"
