package com.condominio.sistema.repository;

import com.condominio.sistema.model.Vivienda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ViviendaRepository extends JpaRepository<Vivienda, Integer> {

    List<Vivienda> findByEstado(String estado);

    Optional<Vivienda> findByNumeroAndBloque(String numero, String bloque);
}
