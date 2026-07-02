<?= $this->extend('layout') ?>
<?= $this->section('content') ?>
<div class="row">
    <div class="col-lg-6">
        <?= form_open('buy', 'class="row g-3"') ?>

        <?= form_hidden('username', session()->get('username')) ?>

        <?= form_input([
            'type' => 'hidden', 
            'name' => 'total_harga', 
            'id' => 'total_harga']) ?>

        <div class="col-12">
            <?= form_label('Nama', 'nama', ['class' => 'form-label']) ?>
            <?= form_input([
                'name'     => 'nama',
                'id'       => 'nama',
                'class'    => 'form-control',
                'value'    => session()->get('username'),
                'readonly' => true]) ?>
        </div>
        <div class="col-12">
            <?= form_label('Alamat', 'alamat', ['class' => 'form-label']) ?>
            <?= form_input([
                'name'  => 'alamat',
                'id'    => 'alamat',
                'class' => 'form-control']) ?>
        </div> 
        <div class="col-12"> 
            <?= form_label('Kelurahan', 'kelurahan', ['class' => 'form-label']) ?>
            <?= form_dropdown('kelurahan', [], '', ['id' => 'kelurahan', 'class' => 'form-control']) ?>
        </div>
        <div class="col-12"> 
            <?= form_label('Layanan', 'layanan', ['class' => 'form-label']) ?> 
            <?= form_dropdown('layanan', [], '', ['id' => 'layanan', 'class' => 'form-control']) ?>
        </div>
        <div class="col-12">
            <?= form_label('Ongkir', 'ongkir', ['class' => 'form-label']) ?>
            <?= form_input([
                'name'     => 'ongkir',
                'id'       => 'ongkir',
                'class'    => 'form-control',
                'readonly' => true]) ?>
        </div>
        <div class="col-12">
            <?= form_label('Kode Kupon', 'kupon_code', ['class' => 'form-label']) ?>
            <?= form_input([
                'name'  => 'kupon_code',
                'id'    => 'kupon_code',
                'class' => 'form-control',
                'placeholder' => 'Masukkan kode kupon (opsional)']) ?>
            <small class="text-muted">
                Tersedia: <?= implode(', ', array_keys($kuponList)) ?>
            </small>
        </div>
        <div class="col-12">
            <?= form_submit(
                'submit',
                'Buat Pesanan',
                ['class' => 'btn btn-primary']) ?>
        </div>

        <?= form_close() ?> 
    </div>
    <div class="col-lg-6">
        <table class="table">
        <thead>
            <tr>
                <th scope="col">Nama</th>
                <th scope="col">Harga</th>
                <th scope="col">Jumlah</th>
                <th scope="col">Sub Total</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if (!empty($items)):
                foreach ($items as $index => $item):
                    ?>
                            <tr>
                                <td><?= $item['name'] ?></td>
                                <td><?= number_to_currency($item['price'], 'IDR') ?></td>
                                <td><?= $item['qty'] ?></td>
                                <td><?= number_to_currency($item['price'] * $item['qty'], 'IDR') ?></td>
                            </tr>
                    <?php
                endforeach;
            endif;
            ?>
            <tr>
                <td colspan="2"></td>
                <td>Subtotal</td>
                <td><?= number_to_currency($total, 'IDR') ?></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td>Diskon Kupon <span id="kupon_persen"></span></td>
                <td class="text-danger">-<span id="diskon_kupon_text"><?= number_to_currency(0, 'IDR') ?></span></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td>PPN (12%)</td>
                <td><span id="ppn_text"><?= number_to_currency(0, 'IDR') ?></span></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td>Biaya Admin</td>
                <td><span id="biaya_admin_text"><?= number_to_currency(0, 'IDR') ?></span></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td>Subtotal (+PPN+Admin-Kupon)</td>
                <td><span id="subtotal_akhir_text"><?= number_to_currency($total, 'IDR') ?></span></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td>Grand Total (incl. Ongkir)</td>
                <td><span id="total"><?= number_to_currency($total, 'IDR') ?></span></td>
            </tr>
        </tbody>
        </table>
    </div>
</div>
<?= $this->endSection() ?>

<?= $this->section('script') ?>
<script>
    $(document).ready(function () {
        let ongkir = 0;
        let subtotal = <?= $total ?>;
        const kuponList = <?= json_encode($kuponList) ?>; // { HEMAT20: 20, HEMAT30: 30, MEMBER25: 25 }
        const PPN_RATE = 0.12;

        hitungTotal();

        function formatIDR(num) {
            return `IDR ${Math.round(num).toLocaleString('id-ID')}`;
        }

        function hitungBiayaAdmin(total_harga) {
            let tarif;
            if (total_harga <= 15000000) {
                tarif = 0.005;
            } else if (total_harga <= 35000000) {
                tarif = 0.007;
            } else {
                tarif = 0.009;
            }
            return total_harga * tarif;
        }

        function hitungDiskonKupon(total_harga, kuponCode) {
            const code = (kuponCode || '').trim().toUpperCase();
            if (!code || !(code in kuponList)) {
                return { persen: 0, nilai: 0 };
            }
            const persen = kuponList[code];
            return { persen: persen, nilai: total_harga * (persen / 100) };
        }

        function hitungTotal() {
            const kuponCode = $("#kupon_code").val();
            const diskon = hitungDiskonKupon(subtotal, kuponCode);
            const ppn = subtotal * PPN_RATE;
            const biayaAdmin = hitungBiayaAdmin(subtotal);

            const subtotalAkhir = subtotal - diskon.nilai + ppn + biayaAdmin;
            const total = subtotalAkhir + ongkir;

            $("#ongkir").val(ongkir);
            $("#kupon_persen").text(diskon.persen > 0 ? `(${diskon.persen}%)` : '');
            $("#diskon_kupon_text").text(formatIDR(diskon.nilai));
            $("#ppn_text").text(formatIDR(ppn));
            $("#biaya_admin_text").text(formatIDR(biayaAdmin));
            $("#subtotal_akhir_text").text(formatIDR(subtotalAkhir));
            $("#total").text(formatIDR(total));
            $("#total_harga").val(total);
        }

        $("#kupon_code").on('keyup change', function () {
            hitungTotal();
        });

        $('#kelurahan').select2({
            placeholder: 'Cari daerah tujuan',
            minimumInputLength: 3,
            ajax: {
                url: '<?= site_url('ajax/destinations') ?>',
                dataType: 'json',
                delay: 300,
                data: function(params) {
                    return {
                        q: params.term
                    };
                },
                processResults: function(data) {
                    return data;
                },
                cache: true
            }
        });

        $("#kelurahan").on('change', function () {
            let id_kelurahan = $(this).val();

            $("#layanan").empty();
            ongkir = 0;
            hitungTotal(); 

            $.ajax({
                url: "<?= site_url('ajax/costs') ?>", 
                dataType: "json",
                data: {
                    destination: id_kelurahan
                },
                success: function (data) { 
                    data.forEach(function (item) {
                        $("#layanan").append(
                            $('<option>', {
                                value: item.cost,
                                text: `${item.description} (${item.service}) : estimasi ${item.etd}`
                            })
                        );
                    });
                }
            });
        });

    $("#layanan").on('change', function() {
        ongkir = parseInt($(this).val());
        hitungTotal();
    }); 
});
</script>
<?= $this->endSection() ?>