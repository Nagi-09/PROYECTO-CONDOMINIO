package com.condominio.sistema.repository;

import com.condominio.sistema.model.ViviendaPersona;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ViviendaPersonaRepository
        extends JpaRepository<ViviendaPersona, Integer> {

}