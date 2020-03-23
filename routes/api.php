<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('register', 'PetugasController@register');
Route::post('login', 'PetugasController@login');
Route::get('/', function() {
  return Auth::user()->level;
})->middleware('jwt.verify');


Route::post('tambah_pelanggan', 'PelangganController@store')->middleware('jwt.verify');
Route::put('edit_pelanggan/{id}', 'PelangganController@update')->middleware('jwt.verify');
Route::delete('hapus_pelanggan/{id}', 'PelangganController@destroy')->middleware('jwt.verify');

Route::post('tambah_jenis', 'Jenis_CuciController@store')->middleware('jwt.verify');
Route::put('edit_jenis/{id}', 'Jenis_CuciController@update')->middleware('jwt.verify');
Route::delete('hapus_jenis/{id}', 'Jenis_CuciController@destroy')->middleware('jwt.verify');

Route::post('tambah_detail', 'Detail_TransController@store')->middleware('jwt.verify');
Route::put('edit_detail/{id}', 'Detail_TransController@ubah')->middleware('jwt.verify');
Route::delete('hapus_detail/{id}', 'Detail_TransController@destroy')->middleware('jwt.verify');

Route::post('tambah_trans', 'TransaksiController@store')->middleware('jwt.verify');
Route::put('edit_trans/{id}', 'TransaksiController@update')->middleware('jwt.verify');
Route::delete('hapus_trans/{id}', 'TransaksiController@destroy')->middleware('jwt.verify');
Route::post('tampil_trans', 'TransaksiController@get_transaksi')->middleware('jwt.verify');
