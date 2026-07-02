<?php

/**
 * Helper untuk perhitungan tambahan pada proses checkout:
 * - PPN
 * - Biaya Admin (tarif berjenjang)
 * - Diskon Kupon Promo
 */

if (! function_exists('get_kupon_list')) {
    
    function get_kupon_list(): array
    {
        return [
            'HEMAT20'  => 20,
            'HEMAT30'  => 30,
            'MEMBER25' => 25,
        ];
    }
}

if (! function_exists('hitung_ppn')) {
    
    function hitung_ppn(float $total_harga): float
    {
        $tarif_ppn = 0.12;

        return $total_harga * $tarif_ppn;
    }
}

if (! function_exists('hitung_biaya_admin')) {
    
    function hitung_biaya_admin(float $total_harga): float
    {
        if ($total_harga <= 15000000) {
            $tarif = 0.005;
        } elseif ($total_harga <= 35000000) {
            $tarif = 0.007;
        } else {
            $tarif = 0.009;
        }

        return $total_harga * $tarif;
    }
}

if (! function_exists('hitung_diskon_kupon')) {
    
    function hitung_diskon_kupon(float $total_harga, ?string $kupon_code = null): float
    {
        $kupon_code = strtoupper(trim((string) $kupon_code));

        if ($kupon_code === '') {
            return 0;
        }

        $kuponList = get_kupon_list();

        if (! isset($kuponList[$kupon_code])) {
            return 0;
        }

        return $total_harga * ($kuponList[$kupon_code] / 100);
    }
}
