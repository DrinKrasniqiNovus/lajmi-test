import 'package:flutter/material.dart';

class GeneralTerms extends StatefulWidget {
  const GeneralTerms({Key? key}) : super(key: key);

  @override
  State<GeneralTerms> createState() => _GeneralTermsState();
}

class _GeneralTermsState extends State<GeneralTerms> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Kushtet e Përgjithshme\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
        text: '        \n',
      ),
      TextSpan(
          text:
              'Këto Kushte të Përgjithshme janë të vlefshme për Aplikacionin e Lajmi.net të qasshëm në PlayStore dhe AppStore (tutje “Aplikacioni”) dhe për vizitorët e saj (tutje "Përdorues"). Ju lutem, ta keni parasysh se pronar i Aplikacionit është Lajmi.net SH.P.K. me seli të regjistruar në Zenel Salihu nr. 28, zyrja nr. 5, 10000 Prishtina, Kosovë dhe numër të regjistruar 810830738 (tutje “Lajmi.net”). Përdorimi i Aplikacionit nënkupton që Përdoruesi pranon plotësisht të gjitha Kushtet e Përgjithshme të Aplikacionit dhe Rregulloren e Privatësisë dhe Sigurisë së të Dhënave. Lajmi.net ruan të drejtën, kurdo që është e nevojshme, të ndryshojë Kushtet e Përgjithshme të Aplikacionit, Rregulloren e Privatësisë dhe Sigurisë së të Dhënave, si dhe çdo kusht, rregullore, udhëzim ose paralajmërim tjetër.Përmes këtij Aplikoacioni, Lajmi.net ofron lidhje të veçanta me materiale të ndryshme, informacione dhe të dhëna të bëra të qasshme për Përdoruesin. Lajmi.net do të ketë të drejtën të ndryshojë prezantimin, paraqitjen dhe vendndodhjen e Aplikacionit, si dhe Përmbajtjen dhe Kushtet, në çdo kohë.Përdorimi i Aplikacionit është falas dhe nën përgjegjësinë e vetme të përdoruesit. Duke hyrë në aplikacion, dhe faqet e tjera të lidhura, përfshirë por pa u kufizuar në faqet e mediave sociale, ju pranoni të gjitha Kushtet e Aplikacionit në fuqi, çdo herë që Përdoruesi qaset në aplikacion. Lajmi.net ruan të drejtën e pakushtëzuar për të mbyllur aplikacionin, për të ndryshuar domenin, për të pezulluar, ndërprerë ose pushuar së funksionuari aplikacionin pa asnjë obligim apo përgjegjësi ndaj vizitorëve të saj dhe palëve të tjera të treta.Lajmi.net nuk bën përfaqësime për vazhdimësinë, saktësinë dhe besueshmërinë e informacionit të paraqitur në aplikacion. Përmbajtja e Aplikacionit është vetëm për qëllime informacioni dhe nuk mund të përdoret nga asnjë palë për t’u bazuar  për qëllime të tjera.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'Informacion mbi Përdoruesit\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
          text:
              'Përdoruesi vërteton dhe pranon që qasja në aplikacion dhe/ose Përmbajtje është falas dhe nën përgjegjësinë e tyre të vetme. Përdoruesi bie dakord të përdorë ligjërisht dhe në mënyrë të përshtatshme këtë aplikacion dhe materialet e tij, në përputhje me legjislacionin në fuqi.Përdoruesi duhet të shmangë:\n●	Përdorimin e paautorizuar të Aplikacionit dhe përpjekjen për të hyrë në zonat e kufizuara të këtij aplikacioni, pa respektuar kushtet e kërkuara për një qasje të tillë;\n●	Përdorimin e Aplikacionit dhe/ose Përmbajtjes së tij për qëllime jolegjitime ose të paligjshme, në kundërshtim me kushtet e përcaktuara në këto Kushte të Përgjithshme, shkaktimin e demit të strukturave fizike ose logjike të Lajmi.net, duke shpërndarë viruse në rrjete ose ndonjë sistem fizik ose regjistër;\n●	Printimin, kopjimin, transmetimin, lejimin e qasjes në publik përmes çdo forme të medias, modifikimin ose përmirësimn e përmbajtjes, përveç rasteve kur mbajtësi i të drejtave të tilla ose përfaqësuesi i tij ligjor autorizon Përdoruesin ta bëjë këtë;\n●	Mos respektimin e të drejtave të pronësisë industriale ose intelektuale të materialeve të prodhuara nga Lajmi.net,  përpjekjen për të marrë Materialin me mjete ose procedura të ndryshme nga ato mjete ose procedura të vëna në dispozicion.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'Lidhjet e veçanta\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
          text:
              'Përdoruesit që dëshirojnë të lidhen në ose përmes Aplikacionit së Lajmi.net do të marrin autorizim paraprak nga Lajmi.net dhe do ti nënshtrohen respektimit të detyrimeve të mëposhtme:\n●	lidhja do të sigurojë qasje ekskluzive në aplikacion, çdo riprodhim do të ndalohet;\n●	asnjë lidhje me faqe të tjera përveç faqes fillestare të Aplikacionit  së Lajmi.net.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'Cookies në aplikacion\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
          text:
              'Cookies instalohen përmes Aplikacionit dhe transferohen në pajisjen tuaj për të mundësuar që sistemet të njohin pajisjen tuaj dhe të ofrojnë tipare të personalizuara. Lajmi.net lejon dhe përdor cookie të faqeve të internetit për të personalizuar dhe maksimizuar përvojën e palëve të treta në aplikacion të Lajmi.net. Përdoruesit mund të çaktivizojnë cookie-t në shfletuesit e tyre duke mos lejuar që shfletuesit të pranojnë cookie-t e reja, dhe që Aplikacioni t’i njoftojë përdoruesit për cookies dhe t’i çaktivizojë ato.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'Markat tregtare dhe të drejtat e autorit\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
          text:
              'Të gjitha palët dhe përdoruesit që hyjnë në aplikacionin e Lajmi.net dhe faqe të tjera të lidhura, njohin dhe pranojnë të drejtat e pronësisë industriale dhe intelektuale të Lajmi.net. E gjithë prona intelektuale dhe të drejtat e lidhura me materialet, duke përfshirë por pa u kufizuar në markat, logot, emrat tregtarë, tekstin, imazhet, bisedat, audio dhe video, bazën e të dhënave, programet kompjuterike, mbahen nga Lajmi.net dhe janë nën pronësinë ekskluzive të Lajmi.net Sh.P.K. me seli të regjistruar në Kosovë.Qasja në aplikacion dhe format tjera të komunikimit me Lajmi.net, në asnjë rrethanë, nuk garanton heqje dore, vazhdimësi, licencë ose caktim të ndonjë të drejte në lidhje me materiale të tilla.Materiali dhe përmbajtja e vënë në dispozicion ose e zhvilluar nga Lajmi.net, duke përfshirë por pa u kufizuar në tekstin, grafikën, ikonat e butonave, imazhet, tabelat, smartartin, klipet zanore, përpilimin e të dhënave, është pronë e Lajmi.net dhe mbrohet nga Kosova, BE, dhe ligjet ndërkombëtare të së drejtës së autorit. Gjithashtu, një përmbledhje e këtyre përmbajtjeve ose produkteve derivate është pronë ekskluzive e Lajmi.net dhe e mbrojtur nga Kosova dhe ligjet ndërkombëtare të së drejtës së autorit.Për më tepër, emri tregtar Lajmi.net, logoja, grafika, ikonat, fotografitë dhe emrat e shërbimeve të ndërlidhura të zhvilluara ose të vëna në dispozicion përmes Lajmi.net janë marka tregtare të Lajmi.net Sh.P.K. me seli të regjistruar në Prishtinë. Markat tregtare të Lajmi.net nuk mund të përdoren nga palë të treta pa pëlqimin paraprak me shkrim të Lajmi.net, dhe palët e treta nuk mund të lidhin marka të tilla tregtare me shërbimet që nuk janë të Lajmi.net.Markat tregtare të vëna në dispozicion nga Lajmi.net përmes faqes së saj të internetit, mediave sociale dhe mediave në përgjithësi, të cilat nuk janë zhvilluar nga ose nuk janë në pronësi të Lajmi.net, janë pronë e pronarëve të tyre përkatës dhe vihen në dispozicion nga Lajmi.net përmes marrëveshjeve ligjore specifike.Përdoruesi pajtohet dhe njeh që të gjitha markat tregtare dhe të drejtat e pronësisë intelektuale në Përmbajtje dhe/ose çdo gjë tjetër e përdorur në aplikacionin e Lajmi.net. Hyrja në Aplikacion në asnjë rrethanë nuk garanton heqje dorë, transferim, autorizim ose caktim të pjesshëm ose të plotë të të drejtave të tilla, përveç rasteve kur jepet shprehimisht ndryshe. Përdorimi, dyfishimi, komunikimi dhe/ose shpërndarja e elementeve të tilla për qëllime përfitimi ose komerciale është rreptësisht e ndaluar, siç është çdo ndryshim ose fragmentim i tyre. Leja paraprake e mbajtësit të këtyre të drejtave do të kërkohet me shkrim për çdo përdorim tjetër nga ai i lejuar në mënyrë specifike. Nëse ligjet e tilla shkelen, Lajmi.net do të ngrejë procedura ligjore kundër autoriteteve kompetente për shkelje të të drejtave të markës tregtare dhe pronësisë intelektuale.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'Ankesat\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
          text:
              'Nëse ndonjë palë e tretë beson se Lajmi.net në çfarëdo mënyre ka shkelur pronësinë e tyre intelektuale ose ka kryer ndonjë shkelje të të dhënave, duhet të kontaktojë menjëherë Lajmi.net dhe ti njoftojë ata për pretendimet e tyre, përmes emailit info@lajmi.net ose përmes telefonit të listuar në aplikacion  +383 (0) 49 131 131.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'E drejta e zbatueshme dhe juridiksioni\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
          text:
              'Informacioni i përfshirë në aplikacionin e Lajmi.net dhe Kushtet e Përgjithshme të Aplikacionit rregullohen nga ligji në fuqi i Republikës së Kosovës, me juridiksion ekskluziv të Gjykatave në Prishtinë, Republika e Kosovës.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'RREGULLORJA E PRIVATËSISË DHE SIGURISË SË TË DHËNAVE\n',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      TextSpan(
          text:
              'Rregullorja e Privatësisë dhe Sigurisë së të Dhënave të webfaqes Lajmi.net siguron që të dhënat e marra nga palët e interesuara dhe përdoruesve gjatë kohës që vizitojnë aplikacionin, regjistrohen në buletin, përgjigjen në sondazhe, plotësojnë një formular apo ofrojnë informata në lidhje me aktivitetet, shërbimet, veçoritë ose burimet e tjera që i vëmë në dispozicion në Aplikacion tonë do të mbeten nën kontrollin e vetëm të Lajmi.net dhe janë plotësisht të sigurta. Misioni ynë është t’i kontaktojmë, informojmë dhe t’iu ofrojmë përdoruesve Produktet që Lajmi.net ka për t’i ofruar dhe për të cilat përdoruesi ka dhënë pëlqimin e tij.Lajmi.net nuk mbledh të dhëna personale pa njoftim paraprak dhe marrje të pëlqimit. Në rast të procesimit të të dhënave përmes formave të ndryshme të përmendura më lartë gjatë përdorimit të Aplikacionit, Lajmi.net do të mbledhë të dhënat e mëposhtme:\n●	emri dhe mbiemri;\n●	numri i telefonit dhe email adresa;tutje (“të Dhënat”).Të Dhënat e mbledhura do të përdoren nga Lajmi.net për qëllime të analizave, hulumtimeve, kontaktimi, informimi, dhe për ofrimin e Produkteve apo infromacioneve, prandaj të Dhënat do të përdoren vetëm nga stafi ynë.Lajmi.net kupton rëndësinë më të madhe të vlerës së të Dhënave të Klientëve/Përdoruesve të tij dhe zbaton të gjitha masat për të garantuar sigurinë dhe moskompromentimin e të Dhënave të tilla, duke qenë plotësisht në përputhje me standardet ligjore. Në këtë drejtim, Lajmi.net zbaton masa të rrepta sigurie për të Dhënat e mbledhura fizikisht dhe online, duke siguruar që të Dhënat të mos komprometohen nga asnjë veprim ose mosveprim nga ana jonë.Informacioni i mbledhur është një pjesë e rëndësishme e punës sonë, dhe ruajtja e informacionit të tillë me standardet më të larta të sigurisë është një nga shtyllat e punës sonë. Ngjashëm me sigurinë e të dhënave, me të njëjtat standarde të larta, Lajmi.net siguron që informacioni i dhënë të përpunohet me saktësi, efikasitet dhe konfidencialitet.Ju lutem ta keni parasysh se procesues i të Dhënave tuaja është Lajmi.net (“Processor”). Nëse keni ndonjë pyetje në lidhje me përpunimin e të Dhënave tuaja, ju lutem na kontaktoni në adresat e mëposhtme: \n-	info@lajmi.net\nLajmi.net mban protokoll të rreptë të sigurisë së të dhënave për të gjitha të dhënat, duke përfshirë por pa u kufizuar në:\n●	Qasjen e kontrolluar në të gjitha ndërtesat dhe verifikimin e të gjitha hyrjeve në ndërtesë;\n●	Qasjen e kufizuar në të dhëna për punonjësit e para-identifikuar të Lajmi.net, të gjithë të trajnuar plotësisht dhe nën përgjegjësinë ligjore për ruajtjen dhe mbrojtjen e të gjitha të dhënave;\n●	Qasjen e mbrojtur me fjalëkalim në operacionet e rrjetit dhe qasje e kufizuar në funksionimin e rrjetit te menaxherët e paracaktuar;\n●	Transferimin e sigurtë të të gjitha të dhënave dhe qasjen e kufizuar në të dhëna të tilla vetëm te menaxherët e paracaktuar;\n●	Sistem të avancuar të monitorimit nga Mbikëqyrësit e punës së punonjësve.Lajmi.net mirëmban po ashtu një protokoll të rreptë të sigurisë së të dhënave të rrjetit për të gjitha të dhënat, duke përfshirë por pa u kufizuar në masat të tilla si:\n●	Rezervimi i rregullt i të Dhënave dhe ruajtja në një objekt të jashtëm të sigurt, të papërshkueshëm nga zjarri;\n●	Mbrojtja e rrjetit lokal me firewall;\n●	Pajisjet e punës të mbrojtura me fjalëkalim;\n●	Fjalëkalime të koduara;\n●	Instalimi i sistemeve të zbulimit të ndërhyrjeve në rrjet.Çdo punonjës është trajnuar në protokollet e sigurisë dhe merr përsipër përgjegjësi të rreptë ligjore për të gjitha aspektet e sigurisë së të dhënave dhe mbrojtjes së të dhënave personale.Lajmi.net ka diskrecionin për të përditësuar këtë politikë të privatësisë në çdo kohë. Kur të ndodhë një gjë e tillë, ne do të postojmë një njoftim në faqen kryesore të Aplikacionis, do të rishikojmë datën e përditësuar në fund të kësaj faqeje. Ne i inkurajojmë përdoruesit që ta kontrollojnë shpesh këtë faqe për çdo ndryshim për të qëndruar të informuar se si po ndihmojmë në mbrojtjen e të dhënave personale që mbledhim. Ju e pranoni dhe pranoni se është përgjegjësia juaj të rishikoni periodikisht këtë politikë të privatësisë dhe të bëheni të vetëdijshëm për modifikimet.Prandaj, të Dhënat e mbledhura janë plotësisht të mbrojtura dhe mund të përqëndrohen në punën e tyre thelbësore, ndërkohë që merrni shërbime të besueshme apo informata të tjera që i ja kanë transmetuar Lajmi.net, duke qenë të sigurt për integritetin e të dhënave.Mbledhja e të dhënave personale në Aplikacion, përpunimi dhe ruajtja e të dhënave të tilla personale do të trajtohen në përputhje me kornizën ligjore në fuqi në Republikën e Kosovës. Me përfshirjen e të dhënave personale në forma  të ndryshme brenda Aplikacionit, nën lejen e përdoruesit, Përdoruesi njeh dhe pranon përpunimin dhe ruajtjen e të dhënave të tilla personale për qëllime të lejuara me ligj.Lajmi.net nuk do ti transferojë të dhënat personale palëve të treta pa marrë pëlqimin paraprak nga Përdoruesi.Përpunimi për qëllimet e përmendura më sipër do të kryhet gjithmonë me pëlqimin paraprak të Klientit. Në mënyrë të ngjashme, në rast se Klienti tërheq pëlqimin e tij për çdo përpunim, ligjshmëria e përpunimit të kryer më parë nuk do të cënohet.\n',
          style: TextStyle(color: Colors.black)),
      TextSpan(
        text: '        \n',
      ),
      TextSpan(
          text:
              '\"Duke klikuar kutinë ju pajtoheni me Termet e Përgjithshme dhe Rregulloren e Privatësisë dhe Sigurisë së të dhënave të Lajmi.net\"\n',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontStyle: FontStyle.normal)),
    ]));
  }
}
