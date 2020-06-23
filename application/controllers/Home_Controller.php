<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home_Controller extends CI_Controller {


	public function __construct()
	{

		parent::__construct();

		$this->load->model('Role_model');

	}


	public function index()
	{

		$this->load->view('Home');
	}

	// cargar url base.
	public function getUrl()
	{

		echo base_url();
	}

   

// metodos insertar usuario
	public function insertarUsuario()
{
	
	$usuario_data = array(
		'Nombre' => 'Eddy',
		'Apellido' => 'Diaz',
		'Fecha_ingreso' => date('Y-m-d'),
		'Estado' => 1,
		'Correo_electronico' => 'devprogramity@gmail.com',
		'Clave' => password_hash('123', PASSWORD_BCRYPT),
		'Foto' => 'user.jpg',
		'Id_rol' => 1,
		'Id_cargo' => 1,
		'Id_departamento' => 1,
		'Id_condominio' => 2
 
	);

	$this->db->insert('Usuario', $usuario_data);


}


// metodos insertar Rol.
public function insertarRol()
{

	$rol_data = array(
		'Nombre' => 'Administrador',
		'Descripcion' => 'Administrador del sistema',
		'Estado' => 1,

	);

	$this->db->insert('Rol', $rol_data);

	
}


// metodo insertar departamento
public function insertarDepartamento()
{

	$departamento_data = array(
		'Nombre' => 'Finanza',
		'Descripcion' => 'Gestionar la contabiladad',
		'Estado' => 1,

	);

	$this->db->insert('Departamento', $departamento_data);

	
}



// metodo insertar departamento
public function insertarCargo()
{

	$cargo_data = array(
		'Nombre' => 'Gerente general',
		'Descripcion' => 'Presidente del condomimio',
		'Id_departamento' => 1,

	);

	$this->db->insert('Cargo', $cargo_data);

	
}


// metodo insertar Condominio
public function insertarCondominio()
{

	$condominio_data = array(
		'Nombre' => 'BESTCONDOS I',
		'Descripcion' => 'Condominio bestcondos',
		'Telefono' => '849-212-7645',
		'Direccion' => 'Santiago de los Caballeros',
		'Ciudad' => 'Santiago, el embrujo',
		'Estado' => 'DISPONIBLE '

	);

	$this->db->insert('Condominio', $condominio_data);

	
}

	function login(){

			$usuario = $this->input->post('usuario');
			$password = $this->input->post('password');
			$login = $this->Role_model->login($usuario, $password);
				
				if ($login) {
					echo 'aqui'; exit;
		      		redirect(base_url());
		      		
				}
				else{ echo 'no aqui'; exit;
					$this->load->view('login');
				}
		
	}

	  public function logout(){
      	$this->session->sess_destroy();
      	// header('./');
      	redirect('./');
    }


}
