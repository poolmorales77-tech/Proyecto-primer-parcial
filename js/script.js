// Datos de las provincias del Ecuador
// ==========================================
const provincias = {
    'pichincha': { nombre: 'Pichincha', region: 'Sierra', capital: 'Quito', poblacion: '2,388,817', area: '13,026 km²', color: '#FF6B6B' },
    'guayas': { nombre: 'Guayas', region: 'Costa', capital: 'Guayaquil', poblacion: '3,645,500', area: '20,436 km²', color: '#4ECDC4' },
    'manabi': { nombre: 'Manabí', region: 'Costa', capital: 'Portoviejo', poblacion: '1,369,780', area: '18,554 km²', color: '#95E1D3' },
    'los-rios': { nombre: 'Los Ríos', region: 'Costa', capital: 'Babahoyo', poblacion: '778,115', area: '7,105 km²', color: '#FFE66D' },
    'santa-elena': { nombre: 'Santa Elena', region: 'Costa', capital: 'Santa Elena', poblacion: '308,693', area: '3,669 km²', color: '#FFAF87' },
    'el-oro': { nombre: 'El Oro', region: 'Costa', capital: 'Machala', poblacion: '600,659', area: '5,823 km²', color: '#F38181' },
    'esmeraldas': { nombre: 'Esmeraldas', region: 'Costa', capital: 'Esmeraldas', poblacion: '536,303', area: '14,893 km²', color: '#A8D8EA' },
    'carchi': { nombre: 'Carchi', region: 'Sierra', capital: 'Tulcán', poblacion: '183,641', area: '3,605 km²', color: '#FF8B94' },
    'imbabura': { nombre: 'Imbabura', region: 'Sierra', capital: 'Ibarra', poblacion: '398,244', area: '4,599 km²', color: '#A29BFE' },
    'tungurahua': { nombre: 'Tungurahua', region: 'Sierra', capital: 'Ambato', poblacion: '504,583', area: '3,334 km²', color: '#FFB6B9' },
    'chimborazo': { nombre: 'Chimborazo', region: 'Sierra', capital: 'Riobamba', poblacion: '478,499', area: '6,569 km²', color: '#FEC8D8' },
    'canar': { nombre: 'Cañar', region: 'Sierra', capital: 'Azogues', poblacion: '271,841', area: '3,908 km²', color: '#BAFFC9' },
    'azuay': { nombre: 'Azuay', region: 'Sierra', capital: 'Cuenca', poblacion: '712,127', area: '8,189 km²', color: '#BAE1FF' },
    'bolivar': { nombre: 'Bolívar', region: 'Sierra', capital: 'Guaranda', poblacion: '183,641', area: '3,254 km²', color: '#FFFFBA' },
    'cotopaxi': { nombre: 'Cotopaxi', region: 'Sierra', capital: 'Latacunga', poblacion: '409,205', area: '6,569 km²', color: '#E0BBE4' },
    'loja': { nombre: 'Loja', region: 'Sierra', capital: 'Loja', poblacion: '506,113', area: '10,790 km²', color: '#FFDFD3' },
    'orellana': { nombre: 'Orellana', region: 'Amazonia', capital: 'Francisco de Orellana', poblacion: '136,396', area: '21,216 km²', color: '#90BE6D' },
    'sucumbios': { nombre: 'Sucumbíos', region: 'Amazonia', capital: 'Nueva Loja', poblacion: '176,472', area: '18,087 km²', color: '#F8AD9D' },
    'napo': { nombre: 'Napo', region: 'Amazonia', capital: 'Tena', poblacion: '103,697', area: '12,383 km²', color: '#CAFFBF' },
    'pastaza': { nombre: 'Pastaza', region: 'Amazonia', capital: 'Puyo', poblacion: '114,002', area: '29,654 km²', color: '#FFD6A5' },
    'morona-santiago': { nombre: 'Morona Santiago', region: 'Amazonia', capital: 'Macas', poblacion: '196,854', area: '24,053 km²', color: '#FDFFB6' },
    'zamora-chinchipe': { nombre: 'Zamora Chinchipe', region: 'Amazonia', capital: 'Zamora', poblacion: '120,416', area: '10,559 km²', color: '#C7CEEA' },
    'galapagos': { nombre: 'Galápagos', region: 'Insular', capital: 'Puerto Baquerizo Moreno', poblacion: '25,124', area: '8,010 km²', color: '#B5EAD7' },
    'santo-domingo': { nombre: 'Santo Domingo de los Tsáchilas', region: 'Costa', capital: 'Santo Domingo', poblacion: '368,013', area: '3,757 km²', color: '#E2B0FF' }
};

// Función para redirigir a la página de la provincia[cite: 10]
function irAProvincia(provincia) {
    const provinciaData = provincias[provincia];
    if (provinciaData) {
        window.location.href = `provincias/${provincia}.html`;
    }
}

// ==========================================
// Registro de Usuario y Gestión de Puntos[cite: 10]
// ==========================================
function pedirNombreUsuario() {
    const nombre = localStorage.getItem('nombreUsuario');
    return nombre ? nombre : 'Invitado';
}

function jugarComoInvitado() {
    const inputNombre = document.getElementById('guest-name');
    let nombre = inputNombre ? inputNombre.value.trim() : '';
    if (!nombre) {
        nombre = 'Invitado';
    }
    localStorage.setItem('nombreUsuario', nombre);
    if (!localStorage.getItem('puntajeUsuario')) {
        localStorage.setItem('puntajeUsuario', '0');
    }
    actualizarHeaderAcciones();
    mostrarPuntaje();
}

function obtenerPuntaje() {
    const puntaje = localStorage.getItem('puntajeUsuario');
    return puntaje ? parseInt(puntaje) : 0;
}

function guardarPuntaje(puntaje, descripcion = 'Puntaje acumulado') {
    localStorage.setItem('puntajeUsuario', String(puntaje));

    // Actualizar historial en vivo: insertar o actualizar la entrada del jugador
    try {
        const nombre = localStorage.getItem('nombreUsuario') || 'Invitado';
        let historial = obtenerHistorial();
        const idx = historial.findIndex(h => h.nombre === nombre);
        if (idx >= 0) {
            historial[idx].puntaje = puntaje;
        } else {
            historial.push({ nombre: nombre, puntaje: puntaje });
        }
        historial.sort((a, b) => b.puntaje - a.puntaje);
        localStorage.setItem('historialPuntuaciones', JSON.stringify(historial));
    } catch (e) {
        console.error('No se pudo actualizar el historial en localStorage', e);
    }

    if (typeof mostrarPuntaje === 'function') {
        mostrarPuntaje();
    }
    enviarPuntajeServidor(puntaje, descripcion);
}

function enviarPuntajeServidor(puntaje, descripcion) {
    const usuarioId = localStorage.getItem('usuarioId');
    if (!usuarioId) {
        return;
    }

    const pathParts = window.location.pathname.split('/');
    const contextPath = pathParts.length > 2 ? '/' + pathParts[1] : '';
    const endpoint = contextPath + '/guardar_puntuaciones.jsp';

    const params = new URLSearchParams();
    params.append('usuarioId', usuarioId);
    params.append('puntuacion', puntaje);
    params.append('descripcion', descripcion);

    fetch(endpoint, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
        body: params.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status !== 'ok') {
            console.warn('No se guardó la puntuación en el servidor:', data.message || data);
        }
    })
    .catch(error => {
        console.error('Error al guardar puntuación en servidor:', error);
    });
}

// ==========================================
// Control de Despliegue del Ranking (UI Limpia)[cite: 10]
// ==========================================
function mostrarPuntaje() {
    const nombreEtiqueta = document.getElementById('nombre-jugador-activo');
    const puntosEtiqueta = document.getElementById('puntos-jugador-activo');
    const cuerpoTabla = document.getElementById('cuerpo-tabla-ranking');
    const btnReiniciar = document.getElementById('btn-reiniciar-partida');
    const btnBorrarTodo = document.getElementById('btn-borrar-ranking');

    if (!nombreEtiqueta || !puntosEtiqueta || !cuerpoTabla) return;

    const nombreActual = localStorage.getItem('nombreUsuario') || 'Invitado';
    const puntajeActual = obtenerPuntaje();
    let historial = obtenerHistorial();
    // Asegurar que el historial mostrado esté ordenado por puntaje (desc)
    historial.sort((a, b) => b.puntaje - a.puntaje);

    nombreEtiqueta.innerText = nombreActual;
    puntosEtiqueta.innerText = puntajeActual;

    let filasHTML = '';
    if (historial.length > 0) {
        const top10 = historial.slice(0, 10);
        top10.forEach((jugador, index) => {
            filasHTML += `
                <tr>
                    <td>${index + 1}</td>
                    <td>${jugador.nombre}</td>
                    <td>${jugador.puntaje}</td>
                </tr>
            `;
        });
    } else {
        filasHTML = `
            <tr>
                <td colspan="3" style="padding: 15px;">No hay récords registrados aún</td>
            </tr>
        `;
    }
    cuerpoTabla.innerHTML = filasHTML;

    if (btnReiniciar) {
        btnReiniciar.replaceWith(btnReiniciar.cloneNode(true));
        document.getElementById('btn-reiniciar-partida').addEventListener('click', reiniciarJuego);
    }

    if (btnBorrarTodo) {
        btnBorrarTodo.replaceWith(btnBorrarTodo.cloneNode(true));
        document.getElementById('btn-borrar-ranking').addEventListener('click', borrarHistorialCompleto);
    }
}

// ==========================================
// Control de Quizzes Completados (ESCUDO INTELIGENTE PARA NIÑOS)[cite: 10]
// ==========================================
function quizYaCompletado(provincia) {
    // 1. Revisamos cuántos puntos reales guardó el niño en su mejor intento[cite: 10]
    let recordProvincia = localStorage.getItem('puntos_maximos_' + provincia);
    recordProvincia = recordProvincia ? parseInt(recordProvincia) : 0;
    
    // 2. Si ya sacó la nota perfecta (2 puntos), ahí sí bloqueamos el quiz por completo[cite: 10]
    if (recordProvincia === 2) {
        return true;
    }

    // 3. ¡EL TRUCO DE REINTENTO!: Si tiene 0 o 1 punto, significa que está corrigiendo sus respuestas.
    // Borramos inmediatamente cualquier candado del almacenamiento para que el HTML no interrumpa el juego.[cite: 10]
    localStorage.removeItem('textQuiz_' + provincia);
    localStorage.removeItem('textQuiz_provincia'); // Respaldo por si se guardó con nombre genérico
    
    let completados = localStorage.getItem('quizzesCompletados');
    if (completados) {
        let lista = JSON.parse(completados).filter(p => p !== provincia);
        localStorage.setItem('quizzesCompletados', JSON.stringify(lista));
    }
    
    return false; // Le da paso libre al HTML para continuar procesando el nuevo intento[cite: 10]
}

function marcarQuizCompletado(provincia) {
    // 1. Evaluar las respuestas seleccionadas en el DOM actual usando data-correcta
    const r1 = document.querySelector('input[name="q1"]:checked');
    const r2 = document.querySelector('input[name="q2"]:checked');

    let puntosDeEsteIntento = 0;
    if (r1 && r1.hasAttribute('data-correcta')) puntosDeEsteIntento++;
    if (r2 && r2.hasAttribute('data-correcta')) puntosDeEsteIntento++;

    // 2. Registrar la mejor nota previa de esta provincia para evitar inflación de puntos
    const recordAnterior = parseInt(localStorage.getItem('puntos_maximos_' + provincia) || '0');
    let totalGlobal = obtenerPuntaje();

    if (puntosDeEsteIntento > recordAnterior) {
        const diferencia = puntosDeEsteIntento - recordAnterior;
        totalGlobal += diferencia;
        localStorage.setItem('puntos_maximos_' + provincia, puntosDeEsteIntento);
        guardarPuntaje(totalGlobal, 'Quiz ' + provincia);
    }

    // 3. Bloquear definitivamente la provincia si cumple la nota perfecta
    const recordActualizado = parseInt(localStorage.getItem('puntos_maximos_' + provincia) || '0');
    let idCaja = `quiz-${provincia}-resultado`;
    if (provincia === 'zamora-chinchipe' && !document.getElementById(idCaja)) {
        idCaja = 'quiz-zamora-resultado';
    }
    const cajaResultado = document.getElementById(idCaja);

    if (recordActualizado === 2) {
        const completados = localStorage.getItem('quizzesCompletados');
        const lista = completados ? JSON.parse(completados) : [];
        if (!lista.includes(provincia)) {
            lista.push(provincia);
            localStorage.setItem('quizzesCompletados', JSON.stringify(lista));
        }
        localStorage.setItem('textQuiz_' + provincia, 'completado');

        if (cajaResultado) {
            cajaResultado.style.color = '#2ecc71';
            cajaResultado.innerText = '¡Excelente! Respondiste todo correctamente. ¡Quiz completado! ⭐';
        }
    } else {
        if (cajaResultado) {
            cajaResultado.style.color = '#e67e22';
            if (puntosDeEsteIntento === 1) {
                cajaResultado.innerHTML = '¡Tienes 1 bien! Cambia tus opciones y vuelve a pulsar el botón para ganar la estrella que falta. 🔄';
            } else {
                cajaResultado.innerHTML = '¡0/2 bien! No te preocupes, vuelve a leer el texto de arriba y cambia tus opciones. ¡Tú puedes! 🔄';
            }
        }
    }

    if (window.opener && window.opener.mostrarPuntaje) {
        window.opener.mostrarPuntaje();
    }
}

// ==========================================
// Control de Provincias Visitadas[cite: 10]
// ==========================================
function provinciasVisitadas() {
    const data = localStorage.getItem('provinciasVisitadas');
    return data ? JSON.parse(data) : [];
}

function marcarProvinciaVisitada(provincia) {
    let visitadas = provinciasVisitadas();
    if (!visitadas.includes(provincia)) {
        visitadas.push(provincia);
        localStorage.setItem('provinciasVisitadas', JSON.stringify(visitadas));
    }
}

function provinciaVisitada(provincia) {
    return provinciasVisitadas().includes(provincia);
}

// ==========================================
// Persistencia Histórica (Ranking)[cite: 10]
// ==========================================
function obtenerHistorial() {
    const historial = localStorage.getItem('historialPuntuaciones');
    return historial ? JSON.parse(historial) : [];
}

function guardarResultadoFinal() {
    const nombre = localStorage.getItem('nombreUsuario');
    const puntaje = obtenerPuntaje();

    if (!nombre) return;

    let historial = obtenerHistorial();
    const idx = historial.findIndex(h => h.nombre === nombre);
    if (idx >= 0) {
        if (puntaje > historial[idx].puntaje) {
            historial[idx].puntaje = puntaje;
        }
    } else {
        historial.push({ nombre: nombre, puntaje: puntaje });
    }
    historial.sort((a, b) => b.puntaje - a.puntaje);
    localStorage.setItem('historialPuntuaciones', JSON.stringify(historial));
}

// ==========================================
// Funciones de Gestión de Reinicios[cite: 10]
// ==========================================
function reiniciarJuego() {
    guardarResultadoFinal();

    // Limpieza de claves del mapa interactivo[cite: 10]
    localStorage.removeItem('nombreUsuario');
    localStorage.removeItem('puntajeUsuario');
    localStorage.removeItem('provinciasVisitadas');
    localStorage.removeItem('quizzesCompletados');
    
    // Limpieza de los sub-récores de niños creados dinámicamente[cite: 10]
    Object.keys(localStorage).forEach(key => {
        if (key.startsWith('puntos_maximos_') || key.startsWith('textQuiz_')) {
            localStorage.removeItem(key);
        }
    });

    let nuevoNombre = prompt('Ingresa tu nombre para una nueva partida:');
    if (!nuevoNombre || nuevoNombre.trim() === '') {
        nuevoNombre = 'Invitado';
    }

    localStorage.setItem('nombreUsuario', nuevoNombre.trim());
    localStorage.setItem('puntajeUsuario', '0');

    location.reload();
}

function borrarHistorialCompleto() {
    if (confirm('⚠️ ¿Estás seguro de que deseas borrar permanentemente el Ranking, todas las puntuaciones y reiniciar el progreso actual?')) {
        localStorage.clear();
        alert('Se han eliminado todos los datos de la aplicación.');
        location.reload();
    }
}

// ==========================================
// Inicialización del DOM de la Aplicación[cite: 10]
// ==========================================
function cerrarSesion() {
    localStorage.removeItem('nombreUsuario');
    localStorage.removeItem('rolUsuario');
    localStorage.removeItem('puntajeUsuario');
    localStorage.removeItem('provinciasVisitadas');
    localStorage.removeItem('quizzesCompletados');
    Object.keys(localStorage).forEach(key => {
        if (key.startsWith('puntos_maximos_') || key.startsWith('textQuiz_')) {
            localStorage.removeItem(key);
        }
    });
    window.location.href = 'index.html';
}

function actualizarHeaderAcciones() {
    const headerAcciones = document.getElementById('header-acciones');
    if (!headerAcciones) return;

    const nombre = localStorage.getItem('nombreUsuario');
    const rol = localStorage.getItem('rolUsuario');

    if (nombre && rol) {
        const destino = rol === 'admin'
            ? `dashboard_admin.jsp?nombre=${encodeURIComponent(nombre)}&rol=${rol}`
            : `dashboard_usuario.jsp?nombre=${encodeURIComponent(nombre)}&rol=${rol}`;

        headerAcciones.innerHTML = `
            <span style="color: #fff; font-weight: bold;">Hola, ${nombre}</span>
            <a href="${destino}" class="btn-control btn-azul" style="padding: 10px 18px; border-radius: 8px; color: #fff; text-decoration: none;">Mi cuenta</a>
            <button type="button" id="btn-logout" class="btn-control btn-rojo" style="padding: 10px 18px; border-radius: 8px; color: #fff; border: none; cursor: pointer; background: #e74c3c;">Salir</button>
        `;

        const logoutBtn = document.getElementById('btn-logout');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', cerrarSesion);
        }
    } else {
        headerAcciones.innerHTML = `
            <a href="login.jsp" class="btn-control btn-azul" style="padding: 10px 18px; border-radius: 8px; color: #fff; text-decoration: none;">Iniciar sesión</a>
            <a href="registro.jsp" class="btn-control btn-verde" style="padding: 10px 18px; border-radius: 8px; color: #fff; text-decoration: none;">Registrarse</a>
        `;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    actualizarHeaderAcciones();
    mostrarPuntaje();

    // Interactividad en mapas de formato vectorial (SVG Paths)[cite: 10]
    const paths = document.querySelectorAll('.provincia-path');
    paths.forEach(path => {
        const id = path.getAttribute('id');
        if (id) {
            const provinciaId = id.toLowerCase().replace('_', '-');
            path.addEventListener('click', function() {
                irAProvincia(provinciaId);
            });
            path.addEventListener('mouseenter', function() {
                const label = document.querySelector(`text[data-provincia="${provinciaId}"]`);
                if (label) {
                    label.style.fontSize = '1em';
                }
            });
        }
    });

    // Interactividad en mapas basados en enlaces de texto absoluto[cite: 10]
    const provinciaLinks = document.querySelectorAll('.provincia-link');
    provinciaLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href && href.includes('.html')) {
            const prov = href.split('/').pop().replace('.html', '');
            if (provinciaVisitada(prov)) {
                link.style.opacity = '0.5';
                link.style.textDecoration = 'line-through';
            }
        }
        link.addEventListener('click', function() {
            const href = link.getAttribute('href');
            if (href && href.includes('.html')) {
                const prov = href.split('/').pop().replace('.html', '');
                marcarProvinciaVisitada(prov);
            }
        });
    });
});

window.addEventListener('pageshow', function(event) {
    if (event.persisted || !document.hidden) {
        actualizarHeaderAcciones();
        mostrarPuntaje();
    }
});

window.addEventListener('visibilitychange', function() {
    if (!document.hidden) {
        actualizarHeaderAcciones();
        mostrarPuntaje();
    }
});