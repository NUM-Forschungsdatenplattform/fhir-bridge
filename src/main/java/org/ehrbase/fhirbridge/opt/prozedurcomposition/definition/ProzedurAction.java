package org.ehrbase.fhirbridge.opt.prozedurcomposition.definition;

import com.nedap.archie.rm.datastructures.Cluster;
import java.lang.String;
import java.time.temporal.TemporalAccessor;
import java.util.List;
import org.ehrbase.client.annotations.Archetype;
import org.ehrbase.client.annotations.Entity;
import org.ehrbase.client.annotations.Path;
import org.ehrbase.fhirbridge.opt.shareddefinition.TransitionDefiningcode;

@Entity
@Archetype("openEHR-EHR-ACTION.procedure.v1")
public class ProzedurAction {
  @Path("/time|value")
  private TemporalAccessor timeValue;

  @Path("/description[at0001]/items[at0049]/value|value")
  private String freitextbeschreibungValue;

  @Path("/description[at0001]/items[at0014]")
  private List<ProzedurDurchfuhrungsabsichtElement> durchfuhrungsabsicht;

  @Path("/protocol[at0053]/items[at0057]")
  private List<Cluster> empfanger;

  @Path("/description[at0001]/items[at0002]/value|value")
  private String nameDerProzedurValue;

  @Path("/description[at0001]/items[at0062]")
  private List<Cluster> multimedia;

  @Path("/ism_transition[at0043]/transition|defining_code")
  private TransitionDefiningcode transitionDefiningcode;

  @Path("/protocol[at0053]/items[at0064]")
  private List<Cluster> erweiterung;

  @Path("/description[at0001]/items[openEHR-EHR-CLUSTER.anatomical_location.v1 and name/value='Details zur Körperstelle']")
  private List<DetailsZurKorperstelleCluster> detailsZurKorperstelle;

  @Path("/ism_transition[at0043]/current_state|defining_code")
  private org.ehrbase.fhirbridge.opt.shareddefinition.ProzedurBeendetDefiningcode prozedurBeendetDefiningcode;

  @Path("/ism_transition[at0043]/careflow_step|defining_code")
  private ProzedurBeendetDefiningcode prozedurBeendetDefiningcodeCareflowStep;

  @Path("/protocol[at0053]/items[at0055]")
  private Cluster antragsteller;

  public void setTimeValue(TemporalAccessor timeValue) {
     this.timeValue = timeValue;
  }

  public TemporalAccessor getTimeValue() {
     return this.timeValue ;
  }

  public void setFreitextbeschreibungValue(String freitextbeschreibungValue) {
     this.freitextbeschreibungValue = freitextbeschreibungValue;
  }

  public String getFreitextbeschreibungValue() {
     return this.freitextbeschreibungValue ;
  }

  public void setDurchfuhrungsabsicht(
      List<ProzedurDurchfuhrungsabsichtElement> durchfuhrungsabsicht) {
     this.durchfuhrungsabsicht = durchfuhrungsabsicht;
  }

  public List<ProzedurDurchfuhrungsabsichtElement> getDurchfuhrungsabsicht() {
     return this.durchfuhrungsabsicht ;
  }

  public void setEmpfanger(List<Cluster> empfanger) {
     this.empfanger = empfanger;
  }

  public List<Cluster> getEmpfanger() {
     return this.empfanger ;
  }

  public void setNameDerProzedurValue(String nameDerProzedurValue) {
     this.nameDerProzedurValue = nameDerProzedurValue;
  }

  public String getNameDerProzedurValue() {
     return this.nameDerProzedurValue ;
  }

  public void setMultimedia(List<Cluster> multimedia) {
     this.multimedia = multimedia;
  }

  public List<Cluster> getMultimedia() {
     return this.multimedia ;
  }

  public void setTransitionDefiningcode(TransitionDefiningcode transitionDefiningcode) {
     this.transitionDefiningcode = transitionDefiningcode;
  }

  public TransitionDefiningcode getTransitionDefiningcode() {
     return this.transitionDefiningcode ;
  }

  public void setErweiterung(List<Cluster> erweiterung) {
     this.erweiterung = erweiterung;
  }

  public List<Cluster> getErweiterung() {
     return this.erweiterung ;
  }

  public void setDetailsZurKorperstelle(
      List<DetailsZurKorperstelleCluster> detailsZurKorperstelle) {
     this.detailsZurKorperstelle = detailsZurKorperstelle;
  }

  public List<DetailsZurKorperstelleCluster> getDetailsZurKorperstelle() {
     return this.detailsZurKorperstelle ;
  }

  public void setProzedurBeendetDefiningcode(
      org.ehrbase.fhirbridge.opt.shareddefinition.ProzedurBeendetDefiningcode prozedurBeendetDefiningcode) {
     this.prozedurBeendetDefiningcode = prozedurBeendetDefiningcode;
  }

  public org.ehrbase.fhirbridge.opt.shareddefinition.ProzedurBeendetDefiningcode getProzedurBeendetDefiningcode(
      ) {
     return this.prozedurBeendetDefiningcode ;
  }

  public void setProzedurBeendetDefiningcodeCareflowStep(
      ProzedurBeendetDefiningcode prozedurBeendetDefiningcodeCareflowStep) {
     this.prozedurBeendetDefiningcodeCareflowStep = prozedurBeendetDefiningcodeCareflowStep;
  }

  public ProzedurBeendetDefiningcode getProzedurBeendetDefiningcodeCareflowStep() {
     return this.prozedurBeendetDefiningcodeCareflowStep ;
  }

  public void setAntragsteller(Cluster antragsteller) {
     this.antragsteller = antragsteller;
  }

  public Cluster getAntragsteller() {
     return this.antragsteller ;
  }
}
