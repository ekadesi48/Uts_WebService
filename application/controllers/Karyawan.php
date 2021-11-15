<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Karyawan extends REST_Controller {

    function __construct($config = 'rest') 
    {
        parent::__construct($config);
    }

    //untuk Menampilkan keseluruhan data
    public function index_get() 
    {
        $id = $this->get('id');
        if ($id == '') 
        {
            $data = $this->db->get('karyawan')->result();
        } else 
        {
            $this->db->where('id', $id);
            $data = $this->db->get('karyawan')->result();
        }
        $result =["took"=>$_SERVER["REQUEST_TIME_FLOAT"],
                  "code"=>200,
                  "message"=>"Response successfully",
                  "data"=>$data];
        header('access-control-allow-mehtods:GET');
        header('access-control-allow-origin:*');
        $this->response($result, 200);
    }

   // untuk menambahkan data baru
    public function index_post() 
    {
        $data = array(
                'id'       => $this->post('id'),
                'nik'              => $this->post('nik'),
                'nama'       => $this->post('nama'),
                'jenis_kelamin'       => $this->post('jenis_kelamin'),
                'tempat_lahir'       => $this->post('tempat_lahir'),
                'telpon'       => $this->post('telpon'),
                'agama'       => $this->post('agama'),
                'alamat'       => $this->post('alamat'),
                'golongan_id'       => $this->post('golongan_id'));
        $insert = $this->db->insert('karyawan', $data);
        if ($insert) 
        {
            $result = ["took"=>$_SERVER["REQUEST_TIME_FLOAT"],
                "code"=>201,
                "message"=>"Data has successfully added",
                "data"=>$data];
            $this->response($result, 201);
        }else 
        {
            $result = ["took"=>$_SERVER["REQUEST_TIME_FLOAT"],
                "code"=>502,
                "message"=>"Failed adding data",
                "data"=>null];
        $this->response($result, 502);
        }
    }

    //untuk mengubah data
    public function index_put() {
        $id = $this->put('id');
        $data = array(
            'id'       => $this->put('id'),
            'nik'              => $this->put('nik'),
            'nama'       => $this->put('nama'),
            'jenis_kelamin'       => $this->put('jenis_kelamin'),
            'tempat_lahir'       => $this->put('tempat_lahir'),
            'telpon'       => $this->put('telpon'),
            'agama'       => $this->put('agama'),
            'alamat'       => $this->put('alamat'),
            'golongan_id'       => $this->put('golongan_id'));
        $this->db->where('id', $id);
        $update = $this->db->update('karyawan', $data);
        if ($update) {
            $this->response($data, 200);
        } else {
            $this->response(array('status' => 'fail', 502));
        }
    }
    
//untuk Menghapus Data
    public function index_delete() 
    {
        $id = $this->delete('id');
        $this->db->where('id', $id);
        $delete = $this->db->delete('karyawan');
        if ($delete) 
        {
            $this->response(array('status' => 'success'), 201);
        }else
        {
            $this->response(array('status' => 'fail', 502));
        }
    }
}
