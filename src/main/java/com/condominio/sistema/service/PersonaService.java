package com.condominio.sistema.service;

import com.condominio.sistema.model.Persona;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PersonaService {

    private final List<Persona> personas = new ArrayList<>();

    private Integer siguienteId = 1;

    public List<Persona> listarTodas() {
        return personas;
    }

    public Optional<Persona> buscarPorId(Integer id) {
        return personas.stream()
                .filter(persona -> persona.getIdPersona().equals(id))
                .findFirst();
    }

    public Persona guardar(Persona persona) {

        if (persona.getIdPersona() == null) {

            persona.setIdPersona(siguienteId);
            siguienteId++;

            personas.add(persona);

        } else {

            for (int i = 0; i < personas.size(); i++) {

                if (personas.get(i).getIdPersona()
                        .equals(persona.getIdPersona())) {

                    personas.set(i, persona);
                    break;
                }
            }
        }

        return persona;
    }

    public void eliminar(Integer id) {
        personas.removeIf(
                persona -> persona.getIdPersona().equals(id)
        );
    }
}