const API_URL = '/api/productos';

let editMode = false;
let editId = null;

// Elementos del DOM
const form = document.getElementById('producto-form');
const formTitle = document.getElementById('form-title');
const submitBtn = document.getElementById('submit-btn');
const cancelBtn = document.getElementById('cancel-btn');
const tbody = document.getElementById('productos-tbody');

// Event Listeners
document.addEventListener('DOMContentLoaded', () => {
    cargarProductos();
});

form.addEventListener('submit', async (e) => {
    e.preventDefault();

    const producto = {
        nombre: document.getElementById('nombre').value,
        precio: parseFloat(document.getElementById('precio').value),
        cantidad: parseInt(document.getElementById('cantidad').value)
    };

    if (editMode) {
        await actualizarProducto(editId, producto);
    } else {
        await crearProducto(producto);
    }

    resetForm();
    cargarProductos();
});

cancelBtn.addEventListener('click', resetForm);

// Funciones CRUD

async function cargarProductos() {
    try {
        const response = await fetch(API_URL);
        const productos = await response.json();
        mostrarProductos(productos);
    } catch (error) {
        console.error('Error al cargar productos:', error);
        tbody.innerHTML = '<tr><td colspan="5" class="loading">Error al cargar productos</td></tr>';
    }
}

async function crearProducto(producto) {
    try {
        const response = await fetch(API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(producto)
        });

        if (response.ok) {
            alert('Producto creado exitosamente!');
        }
    } catch (error) {
        console.error('Error al crear producto:', error);
        alert('Error al crear producto');
    }
}

async function actualizarProducto(id, producto) {
    try {
        const response = await fetch(`${API_URL}/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(producto)
        });

        if (response.ok) {
            alert('Producto actualizado exitosamente!');
        }
    } catch (error) {
        console.error('Error al actualizar producto:', error);
        alert('Error al actualizar producto');
    }
}

async function eliminarProducto(id) {
    if (!confirm('¿Estás seguro de eliminar este producto?')) {
        return;
    }

    try {
        const response = await fetch(`${API_URL}/${id}`, {
            method: 'DELETE'
        });

        if (response.ok) {
            alert('Producto eliminado exitosamente!');
            cargarProductos();
        }
    } catch (error) {
        console.error('Error al eliminar producto:', error);
        alert('Error al eliminar producto');
    }
}

function editarProducto(id, nombre, precio, cantidad) {
    editMode = true;
    editId = id;

    document.getElementById('nombre').value = nombre;
    document.getElementById('precio').value = precio;
    document.getElementById('cantidad').value = cantidad;

    formTitle.textContent = 'Editar Producto';
    submitBtn.textContent = 'Actualizar Producto';
    cancelBtn.style.display = 'block';

    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function mostrarProductos(productos) {
    if (productos.length === 0) {
        tbody.innerHTML = '<tr><td colspan="5" class="loading">No hay productos registrados</td></tr>';
        return;
    }

    tbody.innerHTML = productos.map(p => `
        <tr>
            <td>${p.id}</td>
            <td>${p.nombre}</td>
            <td>$${parseFloat(p.precio).toFixed(2)}</td>
            <td>${p.cantidad}</td>
            <td class="actions">
                <button class="btn btn-edit" onclick="editarProducto(${p.id}, '${p.nombre}', ${p.precio}, ${p.cantidad})">
                    Editar
                </button>
                <button class="btn btn-delete" onclick="eliminarProducto(${p.id})">
                    Eliminar
                </button>
            </td>
        </tr>
    `).join('');
}

function resetForm() {
    form.reset();
    editMode = false;
    editId = null;
    formTitle.textContent = 'Agregar Nuevo Producto';
    submitBtn.textContent = 'Agregar Producto';
    cancelBtn.style.display = 'none';
}
