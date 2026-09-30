package com.condominio.sistema.service;

import com.condominio.sistema.model.Vehiculo;
import com.condominio.sistema.repository.VehiculoRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class VehiculoService {

    private final VehiculoRepository vehiculoRepository;

    public VehiculoService(VehiculoRepository vehiculoRepository) {
        this.vehiculoRepository = vehiculoRepository;
    }

    public List<Vehiculo> listarTodos() {
        return vehiculoRepository.findAll();
    }

    public List<Vehiculo> listarPorVivienda(Integer idVivienda) {
        return vehiculoRepository
                .findByVivienda_IdViviendaOrderByIdVehiculo(idVivienda);
    }

    public Optional<Vehiculo> buscarPorId(Integer id) {
        return vehiculoRepository.findById(id);
    }

    public Optional<Vehiculo> buscarPorPlaca(String placa) {
        return vehiculoRepository.findByPlacaIgnoreCase(placa);
    }

    /**
     * La placa es única en la base de datos. Al editar hay que ignorar la
     * placa que ya tenía el mismo vehículo, si no siempre daría repetida.
     */
    public boolean existeOtraConPlaca(String placa, Integer idVehiculo) {

        if (placa == null || placa.isBlank()) {
            return false;
        }

        return vehiculoRepository.findByPlacaIgnoreCase(placa)
                .filter(vehiculo -> !vehiculo.getIdVehiculo().equals(idVehiculo))
                .isPresent();
    }

    @Transactional
    public Vehiculo guardar(Vehiculo vehiculo) {

        if (vehiculo.getEstado() == null) {
            vehiculo.setEstado(Boolean.TRUE);
        }

        return vehiculoRepository.save(vehiculo);
    }

    @Transactional
    public void eliminar(Integer id) {

        Vehiculo vehiculo = buscarPorId(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Vehículo no encontrado: " + id
                ));

        vehiculoRepository.delete(vehiculo);
    }
}
