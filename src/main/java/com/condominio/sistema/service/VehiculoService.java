package com.condominio.sistema.service;

import com.condominio.sistema.model.Vehiculo;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class VehiculoService {

    private final List<Vehiculo> vehiculos = new ArrayList<>();

    private Integer siguienteId = 1;

    public List<Vehiculo> listarTodos() {
        return vehiculos;
    }

    public Optional<Vehiculo> buscarPorId(Integer id) {
        return vehiculos.stream()
                .filter(vehiculo -> vehiculo.getIdVehiculo().equals(id))
                .findFirst();
    }

    public Vehiculo guardar(Vehiculo vehiculo) {

        if (vehiculo.getIdVehiculo() == null) {

            vehiculo.setIdVehiculo(siguienteId);
            siguienteId++;

            vehiculos.add(vehiculo);

        } else {

            for (int i = 0; i < vehiculos.size(); i++) {

                if (vehiculos.get(i)
                        .getIdVehiculo()
                        .equals(vehiculo.getIdVehiculo())) {

                    vehiculos.set(i, vehiculo);
                    break;
                }
            }
        }

        return vehiculo;
    }

    public void eliminar(Integer id) {
        vehiculos.removeIf(
                vehiculo -> vehiculo.getIdVehiculo().equals(id)
        );
    }
}