# Copyright (c) 2020 Peter Wohlfarth (Appsfactory GmbH), Wladislaw Wagner (Vitasystems GmbH), Dave Petzold (Appsfactory GmbH)
#
# This file is part of Project EHRbase
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



*** Settings ***
# Library                 REST
# Library                 Collections
# Library                 JSONLibrary
Resource                ${EXECDIR}/robot/_resources/suite_settings.robot

Test Setup              generic.prepare new request session    Prefer=return=representation

Force Tags              create



*** Variables ***




*** Test Cases ***
001 Create Body Temperature 
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create body temperature    observation-bodytemp-example.json
    observation.validate response - 201


002 Create Blood Pressure 
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create blood pressure    observation-bloodpressure-example.json
    observation.validate response - 201


003 Create FIO2 
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create FIO2    observation-example-fiO2.json
    observation.validate response - 201


004 Create Heart Rate 
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create heart rate    observation-example-heart-rate.json
    observation.validate response - 201


005 Create Sofa Score
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create sofa score    observation-sofa-score-example.json
    observation.validate response - 201


006 Create Observation Lab
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create observation lab    observation-observationlab-example.json
    observation.validate response - 201


007 Create Observation Using Default Profile
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create observation    observation-example.json
    observation.validate response - 422 (default profile not supported)


008 Create Observation Using Unsupported Profile
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create observation    observation-vitalsigns-example.json
    observation.validate response - 422 (profile not supported)


009 Create Coronavirus Lab Result
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create observation    observation-coronavirusnachweistest-example.json
    observation.validate response - 201


010 Create Body Height
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint
    
	ehr.create new ehr    000_ehr_status.json
	observation.create observation  observation-example-body-height.json
	observation.validate response - 201


011 Create Pregnancy Status
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint

	ehr.create new ehr    000_ehr_status.json
	observation.create pregnancy status    observation-pregnancy-status-example.json
  	observation.validate response - 201


012 Create Frailty Scale Score
	[Documentation]    1. create EHR
	...                2. trigger observation endpoint
	[Tags]             not-ready

	ehr.create new ehr    000_ehr_status.json
	observation.create frailty scale score    observation-frailty-scale-score-example.json
  	observation.validate response - 201


013 Create Heart Rate (valid variants)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             valid
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
    Observation    	        heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             201           0    		  ${EMPTY}
    Observation    	        test  						true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://google.com						           	       test          https://google.com												       missing          	  true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://google.com            		   missing   	   true    		   	  valid      		1990-12-30		  true		   ${10.12}	     Dave's	       	   http://unitsofmeasure.org    	   /min			 false             201           0    		  ${EMPTY}
    Observation    	        123456  					true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      missing										      	   test          missing        													   123te                  true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				missing                     		   364075005	   true    		   	  valid      		2025-01-01		  true		   ${150.38}	 test	           http://unitsofmeasure.org    	   /min			 false             201           0    		  ${EMPTY}
    Observation    	        missing 					true        http://hl7.org/fhir/StructureDefinition/heartrate        final			false     http://terminology.hl7.org/CodeSystem/v2-0203            missing       https://www.charite.de/fhir/CodeSystem/observation-identifiers        abcd                   true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		   	  valid      		2020-02-25		  true		   ${60}	     test	           http://unitsofmeasure.org    	   /min			 false             201           0    		  ${EMPTY}

014 Create Heart Rate (invalid ressourceType)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             ressourceType    invalid
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
    abcd         	        heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            test          https://www.charite.de/fhir/CodeSystem/observation-identifiers        abcd          	     true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         			 abcd    		true    		 valid      		2020-02-25		  true		   ${88.8}	     test	          http://unitsofmeasure.org    	       /min			 false             422           0    		  Dies scheint keine FHIR-Ressource zu sein
    ${12345}    	        heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            test          https://www.charite.de/fhir/CodeSystem/observation-identifiers        abcd          		 true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         			 abcd    		true    		 valid      		2020-02-25		  true		   ${88.8}	     test	          http://unitsofmeasure.org    	       /min			 false             422           0    		  Dies scheint keine FHIR-Ressource zu sein
    missing      	        heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            test          https://www.charite.de/fhir/CodeSystem/observation-identifiers        abcd                  true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         			 abcd    		true    		 valid      		2020-02-25		  true		   ${88.8}	     test	          http://unitsofmeasure.org    	       /min			 false             422           0    		  ResourceType-Property kann nicht gefunden werden
    ${EMPTY}    	        heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            test          https://www.charite.de/fhir/CodeSystem/observation-identifiers        abcd                  true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         			 abcd    		true    		 valid      		2020-02-25		  true		   ${88.8}	     test	          http://unitsofmeasure.org    	       /min			 false             422           0    		  Dies scheint keine FHIR-Ressource zu sein


015 Create Heart Rate (invalid ID)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             ID    invalid
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
    Observation    	        ${EMPTY}  					true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  @value kann nicht leer sein
    Observation    	        ${123456}  					true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.


016 Create Heart Rate (invalid Meta/Profile)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             Meta    Profile    invalid
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
    Observation    	    	heart-rate  				false       http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Default profile is not supported for Observation. One of the following profiles is expected:
    Observation    	    	heart-rate  				true        http://google.com								         final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Profile http://google.com is not supported for Observation. One of the following profiles is expected:
    Observation    	    	heart-rate  				true        test											         final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Canonical URLs must be absolute URLs if they are not fragment references
    Observation    	    	heart-rate  				true        ${1234567890}        									 final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.
    Observation    	    	heart-rate  				true        missing											         final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Default profile is not supported for Observation. One of the following profiles is expected:
    Observation    	    	heart-rate  				true        ${EMPTY}        										 final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  @value kann nicht leer sein


017 Create Heart Rate (invalid Status)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             Status    invalid
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        todo			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             400           0    		  Unknown ObservationStatus code
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        ${123}			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        missing		true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Profile http://hl7.org/fhir/StructureDefinition/heartrate, Element 'Observation.status': mindestens erforderlich = 1, aber nur gefunden 0
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        ${EMPTY}		true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           1    		  @value kann nicht leer sein


018 Create Heart Rate (invalid Identifier)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             Identifier    invalid
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
# invalid Identifier Coding System
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      ${EMPTY}									               Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           1    		  @value kann nicht leer sein
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      test											           Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Coding.system muss eine absolute Referenz sein, nicht eine lokale Referenz
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      ${1234}									 	           Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.
# invalid Identifier Coding Code
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            ${EMPTY}      https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  @value kann nicht leer sein
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            ${12345}      https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.
# invalid Identifier System
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          test															       8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Identifier.system muss eine absolute Referenz sein, nicht eine lokale Referenz
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          ${12345}        												       8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          ${EMPTY}        													   8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  @value kann nicht leer sein
# invalid Identifier Value
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        ${EMPTY}       		  true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  @value kann nicht leer sein
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        ${12345}       		  true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.


019 Create Heart Rate (invalid Category)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             Category    invalid
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
# no category
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       false            true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Profile http://hl7.org/fhir/StructureDefinition/heartrate, Element 'Observation.category': mindestens erforderlich = 1, aber nur gefunden 0
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             false        http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Objekt muss einen Inhalt haben
# invalid Category System
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://google.com										           vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Dieses Element stimmt mit keinem bekannten Slice defined in the profile http://hl7.org/fhir/StructureDefinition/heartrate überein.
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         test										                       vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Dieses Element stimmt mit keinem bekannten Slice defined in the profile http://hl7.org/fhir/StructureDefinition/heartrate überein.
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         ${123456789}                                                       vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         missing													           vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           2    		  A code with no system has no defined meaning. A system should be provided
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         ${EMPTY}                                                           vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           3    		  @value kann nicht leer sein
# invalid Category Code
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         test               true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Dieses Element stimmt mit keinem bekannten Slice defined in the profile http://hl7.org/fhir/StructureDefinition/heartrate überein.
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         ${12345}           true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Fehler beim Parsen von JSON: Der primitive Wert muss ein String sein.
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         ${EMPTY}           true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           2    		  @value kann nicht leer sein
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         missing            true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Dieses Element stimmt mit keinem bekannten Slice defined in the profile http://hl7.org/fhir/StructureDefinition/heartrate überein.


020 Create Heart Rate (invalid Code)
    [Documentation]    1. create EHR
    ...                2. fill json with table values
    ...                3. trigger observation endpoint
    ...                4. validate outcome
    [Tags]             Code    invalid    test
    [Template]         create Observation Heart Rate JSON
#|  ressourceType  |          		ID   			|           meta         											|  	  status  	|                             									Identifier   						                            					  						|                      				category                           					        					|                                        									code          										                            	  |         subject                    |	DateTime	|                      			    	  valueQuantity  			           		            |  dataabsentreason  |  R.-Code  |  ArryNumber  |         				diagnostics 							|
#|                 |                				|  available  | 			profile  								|          		|  avalable  |  			coding.system					|  		coding.code  	|  							     system  		   				  |   		value  		|  available  |  codingavailable  |  				system  									|    	 code       |  available  |  coding available  |  					0.system	  				|  		0.code	  |  				1.system  				|  		1.code	  |  available  |      reference       |                |  available  |		value	|    unit    	 |  			system      		   |    code    |                    |           |              |               												|
# no code
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        false			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  Profile http://hl7.org/fhir/StructureDefinition/heartrate, Element 'Observation.code': mindestens erforderlich = 1, aber nur gefunden 0
# no coding
    Observation    	    	heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   false		  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  mindestens erforderlich = 1, aber nur gefunden 0
# invalid Code Coding 0 System
#    Observation    	    heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  ${EMPTY}
#    Observation    	    heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  ${EMPTY}
#    Observation    	    heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  ${EMPTY}
#    Observation    	    heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  ${EMPTY}
#    Observation    	    heart-rate  				true        http://hl7.org/fhir/StructureDefinition/heartrate        final			true      http://terminology.hl7.org/CodeSystem/v2-0203            Dave          https://www.charite.de/fhir/CodeSystem/observation-identifiers        8867-4_HeartRate       true             true         http://terminology.hl7.org/CodeSystem/observation-category         vital-signs        true			   true			  				http://loinc.org		  				8867-4				http://snomed.info/sct         		   abcd    		   true    		 	  valid      		2020-02-25		  true		   ${88.8}	     pro Minute	       http://unitsofmeasure.org    	   /min			 false             422           0    		  ${EMPTY}