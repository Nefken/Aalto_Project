function[Param]=SampleParam(test);

switch test
    case 12
        samplename='Clean Contact';
        t=0;
        Ox=0;       
    case 13
        samplename='Plasma 10 min';
        t=10;
        Ox=0;
    case 14
        samplename='Plasma 20 min';
        t=20;
        Ox=0;
    case 15
        samplename='Strong Oxidation : 10 min, 200 mbar';
        t=0;
        Ox=200;
    case 16
        samplename='Regular Oxidation : 2 min, 2 mbar';
        t=0;
        Ox=2;
    case 19
        samplename='Regular Oxidation : 2 min, 2 mbar';
        t=0;
        Ox=2;
    case 21
        samplename='Regular Oxidation : 2 min, 2 mbar';
        t=0;
        Ox=2;
    case 22
        samplename='Plasma 5 min';
        t=5;
        Ox=0;
    case 23
        samplename='Plasma 2 min 30s';
        t=2.5;
        Ox=0;
    case 24
        samplename='Oxidation 2 min, 2 mbar after Plasma 10 min'
        t=10;
        Ox=2;
    case 25
        samplename='Regular Oxidation'
        t=0;
        Ox=2;
        
end
Param={samplename,t,Ox};
end
