package com.shohab.CreateApi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name = "department")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Department{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String deptName;



}
