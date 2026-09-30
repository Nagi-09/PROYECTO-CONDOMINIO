package com.condominio.sistema.service;

import com.condominio.sistema.model.Persona;
import com.condominio.sistema.repository.PersonaRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class PersonaService {

    private final PersonaRepository personaRepository;

    public PersonaService(PersonaRepository personaRepository) {
        this.personaRepository = personaRepository;
    }

    public List<Persona> listarTodas() {
        return personaRepository.findAll();
    }

    public Optional<Persona> buscarPorId(Integer id) {
        return personaRepository.findById(id);
    }

    public Optional<Persona> buscarPorDpi(String dpi) {
        return personaRepository.findByDpi(dpi);
    }

    /**
     * El DPI es único en la base de datos, pero hay que tener cuidado al
     * editar: la persona que estamos editando ya tiene ese DPI, así que
     * solo cuenta como repetido si pertenece a otra persona.
     */
    public boolean existeOtroConDpi(String dpi, Integer idPersona) {

        if (dpi == null || dpi.isBlank()) {
            return false;
        }

        return personaRepository.findByDpi(dpi)
                .filter(persona -> !persona.getIdPersona().equals(idPersona))
                .isPresent();
    }

    @Transactional
    public Persona guardar(Persona persona) {

        if (persona.getEstado() == null) {
            persona.setEstado(Boolean.TRUE);
        }

        return personaRepository.save(persona);
    }

    @Transactional
    public void eliminar(Integer id) {

        Persona persona = buscarPorId(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Persona no encontrada: " + id
                ));

        personaRepository.delete(persona);
    }
}
