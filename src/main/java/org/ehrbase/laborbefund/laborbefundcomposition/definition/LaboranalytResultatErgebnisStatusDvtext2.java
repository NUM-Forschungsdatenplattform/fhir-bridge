package org.ehrbase.laborbefund.laborbefundcomposition.definition;

import java.lang.String;
import org.ehrbase.client.annotations.Entity;
import org.ehrbase.client.annotations.OptionFor;
import org.ehrbase.client.annotations.Path;

@Entity
@OptionFor("DV_TEXT")
public class LaboranalytResultatErgebnisStatusDvtext2 implements LaboranalytResultatErgebnisStatusChoiceOrgEhrbaseEhrEncodeWrappersSnakecase77cf3f8b {
  @Path("|value")
  private String ergebnisStatusValue;

  public void setErgebnisStatusValue(String ergebnisStatusValue) {
     this.ergebnisStatusValue = ergebnisStatusValue;
  }

  public String getErgebnisStatusValue() {
     return this.ergebnisStatusValue ;
  }
}
