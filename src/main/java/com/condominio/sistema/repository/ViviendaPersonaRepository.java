package com.condominio.sistema.repository;

import com.condominio.sistema.model.ViviendaPersona;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViviendaPersonaRepository
        extends JpaRepository<ViviendaPersona, Integer> {

    List<ViviendaPersona> findByVivienda_IdViviendaOrderByIdViviendaPersona(
            Integer idVivienda);

    List<ViviendaPersona> findByPersona_IdPersonaOrderByIdViviendaPersona(
            Integer idPersona);
}
