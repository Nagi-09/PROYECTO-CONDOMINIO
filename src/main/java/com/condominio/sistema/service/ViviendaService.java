package com.condominio.sistema.service;

import com.condominio.sistema.model.Vivienda;
import com.condominio.sistema.repository.ViviendaRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ViviendaService {

    private final ViviendaRepository viviendaRepository;

    public ViviendaService(ViviendaRepository viviendaRepository) {
        this.viviendaRepository = viviendaRepository;
    }

    public List<Vivienda> listarTodas() {
        return viviendaRepository.findAll();
    }

    public List<Vivienda> listarPorEstado(String estado) {
        return viviendaRepository.findByEstado(estado);
    }

    public Optional<Vivienda> buscarPorId(Integer id) {
        return viviendaRepository.findById(id);
    }

    @Transactional
    public Vivienda guardar(Vivienda vivienda) {

        if (vivienda.getEstado() == null || vivienda.getEstado().isBlank()) {
            vivienda.setEstado("Ocupada");
        }

        return viviendaRepository.save(vivienda);
    }

    @Transactional
    public void eliminar(Integer id) {

        Vivienda vivienda = buscarPorId(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Vivienda no encontrada: " + id
                ));

        viviendaRepository.delete(vivienda);
    }
}
