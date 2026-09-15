package com.condominio.sistema.controller;

import com.condominio.sistema.model.Persona;
import com.condominio.sistema.service.PersonaService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/personas")
public class PersonaController {

    private final PersonaService personaService;

    public PersonaController(PersonaService personaService) {
        this.personaService = personaService;
    }

    @GetMapping
    public String listar(Model model) {
        model.addAttribute("personas", personaService.listarTodas());
        return "personas/lista";
    }

    @GetMapping("/nuevo")
    public String mostrarFormularioNuevo(Model model) {
        Persona persona = new Persona();
        persona.setEstado(true);

        model.addAttribute("persona", persona);

        return "personas/formulario";
    }

    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Persona persona) {
        personaService.guardar(persona);
        return "redirect:/personas";
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Integer id, Model model) {

        Persona persona = personaService.buscarPorId(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Persona no encontrada: " + id
                ));

        model.addAttribute("persona", persona);

        return "personas/formulario";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminar(@PathVariable Integer id) {
        personaService.eliminar(id);
        return "redirect:/personas";
    }
}