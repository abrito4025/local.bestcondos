<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Role_Model extends CI_Model {


    public function __construct()
    {
        parent::__construct();
        $this->load->database();
    }
    
	public function getRole()
	{
        $this->db->select('*');
        $this->db->from('Rol');
        $query = $this->db->get();

        return $query->result();
	
    }


    	public function login($username,$clave){

		$query = "CALL getAcceso (?, ?)";
        $data = array('_correoUsuario' => $username, '_Clave' => md5($clave));
        $result = $this->db->query($query, $data);

		// $query=$this->db->query("call getAcceso('{$username}','{$clave}')");
		// return $query->result();


		if($result->num_rows() == 1){
            $row = $result->row();

            if (isset($row->_status)) {
                $data = array("_status" => $row->_status, "_msj" => $row->_msj, "_data" => array(), "_action" => $row->_action);
                $this->session->set_userdata($data);
                return false;
            }
            else{
                $data = array("_status" => 1, "_msj" => "", "_data" => 
                array(
                    'UsuarioId' => $row->UsuarioId, 
                    'usuario' => $row->UsuarioCorreo, 
                    'id' => $row->RolId, 
                    'estatus' => $row->UsuarioEstatus
                ), "_action" => NULL);

                $this->session->set_userdata($data);
                return true;
            }
        }
        // $this->session->unset_userdata('user_data');

        return false;
	}
}
