package com.condominio.sistema.service;

import com.condominio.sistema.model.ViviendaPersona;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ViviendaPersonaService {

    private final List<ViviendaPersona> relaciones = new ArrayList<>();

    private Integer siguienteId = 1;

    public List<ViviendaPersona> listarTodas() {
        return relaciones;
    }

    public Optional<ViviendaPersona> buscarPorId(Integer id) {
        return relaciones.stream()
                .filter(relacion ->
                        relacion.getIdViviendaPersona().equals(id))
                .findFirst();
    }

    public ViviendaPersona guardar(ViviendaPersona relacion) {

        if (relacion.getIdViviendaPersona() == null) {

            relacion.setIdViviendaPersona(siguienteId);
            siguienteId++;

            relaciones.add(relacion);

        } else {

            for (int i = 0; i < relaciones.size(); i++) {

                if (relaciones.get(i)
                        .getIdViviendaPersona()
                        .equals(relacion.getIdViviendaPersona())) {

                    relaciones.set(i, relacion);
                    break;
                }
            }
        }

        return relacion;
    }

    public void eliminar(Integer id) {
        relaciones.removeIf(
                relacion ->
                        relacion.getIdViviendaPersona().equals(id)
        );
    }
}