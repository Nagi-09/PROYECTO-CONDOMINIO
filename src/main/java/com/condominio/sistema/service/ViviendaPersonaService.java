package com.condominio.sistema.service;

import com.condominio.sistema.model.ViviendaPersona;
import com.condominio.sistema.repository.ViviendaPersonaRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ViviendaPersonaService {

    private final ViviendaPersonaRepository viviendaPersonaRepository;

    public ViviendaPersonaService(
            ViviendaPersonaRepository viviendaPersonaRepository) {
        this.viviendaPersonaRepository = viviendaPersonaRepository;
    }

    public List<ViviendaPersona> listarTodas() {
        return viviendaPersonaRepository.findAll();
    }

    public Optional<ViviendaPersona> buscarPorId(Integer id) {
        return viviendaPersonaRepository.findById(id);
    }

    public List<ViviendaPersona> listarPorVivienda(Integer idVivienda) {
        return viviendaPersonaRepository
                .findByVivienda_IdViviendaOrderByIdViviendaPersona(idVivienda);
    }

    public List<ViviendaPersona> listarPorPersona(Integer idPersona) {
        return viviendaPersonaRepository
                .findByPersona_IdPersonaOrderByIdViviendaPersona(idPersona);
    }

    @Transactional
    public ViviendaPersona guardar(ViviendaPersona relacion) {

        if (relacion.getEstado() == null) {
            relacion.setEstado(Boolean.TRUE);
        }

        if (relacion.getFechaInicio() == null) {
            relacion.setFechaInicio(java.time.LocalDate.now());
        }

        return viviendaPersonaRepository.save(relacion);
    }

    @Transactional
    public void eliminar(Integer id) {

        ViviendaPersona relacion = buscarPorId(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Relación no encontrada: " + id
                ));

        viviendaPersonaRepository.delete(relacion);
    }
}
