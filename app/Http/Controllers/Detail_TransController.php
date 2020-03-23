<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Detail_TransModel;
use App\Jenis_cuciModel;
use Validator;
use Auth;
use DB;

class Detail_TransController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        if(Auth::user()->level=="petugas") {
        $validator=Validator::make($request->all(),[
          'id_trans'=>'required',
          'id_jenis'=>'required',
          'qty'=>'required'
        ]);

        if($validator->fails()){
          return response()->json($validator->errors()->toJson(),400);
        }
        $harga = Jenis_cuciModel::where('id', $request->id_jenis)->first();
        $subtotal = @$harga->harga_perkilo * $request->qty;

          $insert=Detail_TransModel::insert([
            'id_trans'=>$request->id_trans,
            'id_jenis'=>$request->id_jenis,
            'subtotal'=>$subtotal,
            'qty'=>$request->qty
          ]);

          if($insert){
            $status="sukses";
          }
          else {
            $status="gagal";
          }
          return response()->json(compact('status'));

      }
      else {
        echo "Mohon maaf, data hanya bisa diakses oleh Petugas";
      }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function ubah(Request $request, $id)
    {
        //
        if(Auth::user()->level=="petugas") {
        $validator=Validator::make($request->all(),
        [
          'id_trans'=>'required',
          'id_jenis'=>'required',
          'qty'=>'required'

        ]
      );
      if($validator->fails()) {
        return response()->json($validator->errors());
      }
      $harga = Jenis_cuciModel::where('id', $request->id_jenis)->first();
      $subtotal = @$harga->harga_perkilo * $request->qty;

      $ubah=Detail_TransModel::where('id', $id)->update([
        'id_trans'=>$request->id_trans,
        'id_jenis'=>$request->id_jenis,
        'subtotal'=>$subtotal,
        'qty'=>$request->qty
      ]);
      if($ubah){
        return response()->json(['status'=>1]);
      }
      else {
        return response()->json(['status'=>0]);
      }
    }
    else {
      echo "Mohon maaf, data hanya bisa diakses oleh Petugas";
    }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
        if(Auth::user()->level=="petugas") {
        $hapus=Detail_TransModel::where('id',$id)->delete();
        if($hapus){
          return response()->json(['status'=>1]);
        }
        else {
          return response()->json(['status'=>0]);
        }
      }
      else {
        echo "Mohon maaf, data hanya bisa diakses oleh Petugas";
      }
    }
}
