package com.condominio.sistema.repository;

import com.condominio.sistema.model.Persona;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PersonaRepository extends JpaRepository<Persona, Integer> {

    Optional<Persona> findByDpi(String dpi);

    boolean existsByDpi(String dpi);
}
