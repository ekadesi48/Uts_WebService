<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Cuti extends REST_Controller {

    function __construct($config = 'rest') 
    {
        parent::__construct($config);
    }

    //menampilkan data
    public function index_get()
    {
        $id = $this->get('id');
        $cuti=[];
        if ($id == '')
        {
            $data = $this->db->get('cuti')->result();
            foreach ($data as $row=>$key):
                $cuti[]=[
                        "id"  =>$key->id,
                            "_links" =>[(object)["href" =>"karyawan/{$key->karyawan_id}", 
                                                            "rel"   =>"karyawan",
                                                            "type"  =>"GET"],
                            "tanggal_cuti"  =>$key->tanggal_cuti,
                            "jumlah"=>$key->jumlah]];
            endforeach;
        }else{
            $this->db->where('id', $id);
            $data = $this->db->get('cuti')->result();
        }
        $result = ["took"       =>$_SERVER["REQUEST_TIME_FLOAT"],
                    "code"      =>200,
                    "message"   =>"response successfully",
                    "data"      => $cuti];
        $this->response($result, 200);
    }
}
?>