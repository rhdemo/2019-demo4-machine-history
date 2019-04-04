
package com.redhat.demo.beans;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * A Machine
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "id",
    "name"
})
public class Machine {

    /**
     * The Machine ID
     * (Required)
     * 
     */
    @JsonProperty("id")
    @JsonPropertyDescription("The Machine ID")
    private Integer id;
    /**
     * The machine name
     * (Required)
     * 
     */
    @JsonProperty("name")
    @JsonPropertyDescription("The machine name")
    private String name;

    /**
     * The Machine ID
     * (Required)
     * 
     */
    @JsonProperty("id")
    public Integer getId() {
        return id;
    }

    /**
     * The Machine ID
     * (Required)
     * 
     */
    @JsonProperty("id")
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * The machine name
     * (Required)
     * 
     */
    @JsonProperty("name")
    public String getName() {
        return name;
    }

    /**
     * The machine name
     * (Required)
     * 
     */
    @JsonProperty("name")
    public void setName(String name) {
        this.name = name;
    }

}
