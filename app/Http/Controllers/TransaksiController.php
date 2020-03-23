<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\TransaksiModel;
use Validator;
use Auth;
use DB;

class TransaksiController extends Controller
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

    public function get_transaksi(Request $r)
    {
      if(Auth::user()->level=="petugas") {
      $trans = DB::table('transaksi')
      ->join('pelanggan', 'pelanggan.id', 'transaksi.id_pelanggan')
      ->join('petugas', 'petugas.id', 'transaksi.id_petugas')
      ->where('tgl_transaksi', '>=', $r->tgl_transaksi)
      ->where('tgl_transaksi', '<=', $r->tgl_selesai)
      ->select('transaksi.tgl_transaksi', 'pelanggan.nama', 'pelanggan.alamat', 'pelanggan.telp',
               'transaksi.tgl_selesai', 'transaksi.id')
      ->get();
      $hasil1 = array();

      foreach ($trans as $t) {
        $grand = DB::table('detail_trans')
        ->where('id_trans', '=', $t->id)
        ->groupBy('id_trans')
        ->select(DB::raw('sum(subtotal) as grandtotal'))
        ->first();

        $detail = DB::table('detail_trans')
        ->join('jenis_cuci', 'jenis_cuci.id', '=', 'detail_trans.id_jenis')
        ->where('id_trans', '=', $t->id)
        ->select('detail_trans.*', 'jenis_cuci.*')
        ->get();
        $hasil2 = array();

        foreach ($detail as $d) {
          $hasil2[] = array(
            'id_trans'=>$d->id_trans,
            'nama jenis cuci'=>$d->nama_jenis,
            'qty'=>$d->qty,
            'harga_perkilo'=>$d->harga_perkilo,
            'subtotal'=>$d->subtotal
          );
        }
        $hasil[] = array(
          'tgl_transaksi' => $t->tgl_transaksi,
          'nama_pelanggan' => $t->nama,
          'alamat' => $t->alamat,
          'telp' => $t->telp,
          'tgl_selesai' => $t->tgl_selesai,
          'total_trans' => $grand->grandtotal,
          'detail_trans' => $hasil2,
        );
      }
      return response()->json(compact('hasil'));
    }
      else {
        echo "Maaf, anda bukan Petugas";
      }
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
          'id_pelanggan'=>'required',
          'id_petugas'=>'required',
          'tgl_transaksi'=>'required',
          'tgl_selesai'=>'required'
        ]);
        if($validator->fails()){
          return response()->json($validator->errors()->toJson(),400);
        }
        else {
          $insert=TransaksiModel::insert([
            'id_pelanggan'=>$request->id_pelanggan,
            'id_petugas'=>$request->id_petugas,
            'tgl_transaksi'=>$request->tgl_transaksi,
            'tgl_selesai'=>$request->tgl_selesai
          ]);
          if($insert){
            $status="sukses";
          }
          else {
            $status="gagal";
          }
          return response()->json(compact('status'));
        }
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
    public function update(Request $request, $id)
    {
        //
        if(Auth::user()->level=="petugas") {
        $validator=Validator::make($request->all(),
        [
          'id_pelanggan'=>'required',
          'id_petugas'=>'required',
          'tgl_transaksi'=>'required',
          'tgl_selesai'=>'required'

        ]
      );
      if($validator->fails()) {
        return response()->json($validator->errors());
      }
      $ubah=TransaksiModel::where('id', $id)->update([
        'id_pelanggan'=>$request->id_pelanggan,
        'id_petugas'=>$request->id_petugas,
        'tgl_transaksi'=>$request->tgl_transaksi,
        'tgl_selesai'=>$request->tgl_selesai
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
        $hapus=TransaksiModel::where('id',$id)->delete();
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
