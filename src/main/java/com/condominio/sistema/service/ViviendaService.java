package com.condominio.sistema.service;

import com.condominio.sistema.model.Vivienda;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ViviendaService {

    // Lista temporal mientras todavía no usamos MySQL
    private final List<Vivienda> viviendas = new ArrayList<>();

    private Integer siguienteId = 1;

    public List<Vivienda> listarTodas() {
        return viviendas;
    }

    public Optional<Vivienda> buscarPorId(Integer id) {
        return viviendas.stream()
                .filter(vivienda -> vivienda.getIdVivienda().equals(id))
                .findFirst();
    }

    public Vivienda guardar(Vivienda vivienda) {

        // Si no tiene ID, significa que es una vivienda nueva
        if (vivienda.getIdVivienda() == null) {

            vivienda.setIdVivienda(siguienteId);
            siguienteId++;

            viviendas.add(vivienda);

        } else {

            // Si ya tiene ID, estamos editando una vivienda existente
            for (int i = 0; i < viviendas.size(); i++) {

                if (viviendas.get(i).getIdVivienda()
                        .equals(vivienda.getIdVivienda())) {

                    viviendas.set(i, vivienda);
                    break;
                }
            }
        }

        return vivienda;
    }

    public void eliminar(Integer id) {
        viviendas.removeIf(
                vivienda -> vivienda.getIdVivienda().equals(id)
        );
    }
}