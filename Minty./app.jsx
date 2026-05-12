// App entry — defined last so all component scripts have populated window.
function App(){
  const { DesignCanvas, DCSection, DCArtboard, DCPostIt,
          Logo01, Logo02, Logo03, Logo04, Logo05, Logo06, Logo07, Logo08, Logo09, Logo10, Logo11 } = window;
  return (
    <DesignCanvas>
      <DCSection id="intro" title="Minty · Logo explorations" subtitle="Marketplace for collectible cards — sell, buy, trade with confidence.">
        <DCPostIt x={0} y={0} width={420}>
          <div className="intro">
            <h1>Direction</h1>
            <p>Your starting point already has two great ideas baked in: a <b>rounded card-shaped frame</b> and the <b>period as a beat</b> (very on-brand for a marketplace of mint-condition cards — “Minty.” reads almost like a grading stamp).</p>
            <p>I’ve refined that direction first, then explored 7 alternates that lean harder into each idea — card geometry, the grading-pip, holo foil, and a circular seal — plus in-context tests (app icon, storefront avatar, authenticity stamp on a card).</p>
            <p>Type: <code>Space Grotesk</code> + <code>JetBrains Mono</code> for utility.</p>
            <div className="swatches">
              <div className="sw" style={{background:'#5be7a6'}} title="mint"></div>
              <div className="sw" style={{background:'#2ec77f'}} title="mint 600"></div>
              <div className="sw" style={{background:'#0e3b2a'}} title="deep mint"></div>
              <div className="sw" style={{background:'#0b1410'}} title="ink"></div>
              <div className="sw" style={{background:'#f6f3ec'}} title="cream"></div>
            </div>
          </div>
        </DCPostIt>
      </DCSection>

      <DCSection id="refine" title="Refinements of your direction" subtitle="Same DNA, tightened proportions and details.">
        <DCArtboard id="r1" label="01 · Refined frame" width={460} height={320}><Logo01/></DCArtboard>
        <DCArtboard id="r2" label="02 · As a card" width={460} height={320}><Logo02/></DCArtboard>
        <DCArtboard id="r3" label="03 · Inverted pill" width={460} height={320}><Logo03/></DCArtboard>
      </DCSection>

      <DCSection id="marks" title="Alternate directions" subtitle="Same brand voice, exploring distinct marks & treatments.">
        <DCArtboard id="m1" label="04 · Card-stack mark" width={460} height={320}><Logo04/></DCArtboard>
        <DCArtboard id="m2" label="05 · Grade seal" width={460} height={320}><Logo05/></DCArtboard>
        <DCArtboard id="m3" label="06 · Holo bar" width={460} height={320}><Logo06/></DCArtboard>
        <DCArtboard id="m4" label="07 · Pip period" width={460} height={320}><Logo07/></DCArtboard>
        <DCArtboard id="m5" label="08 · Stacked lockup" width={460} height={320}><Logo08/></DCArtboard>
      </DCSection>

      <DCSection id="ctx" title="In context" subtitle="How the chosen mark behaves at avatar / icon / stamp sizes.">
        <DCArtboard id="c1" label="09 · App icon" width={280} height={280}><Logo09/></DCArtboard>
        <DCArtboard id="c2" label="10 · Storefront avatar" width={280} height={280}><Logo10/></DCArtboard>
        <DCArtboard id="c3" label="11 · Authenticity stamp on card" width={360} height={400}><Logo11/></DCArtboard>
      </DCSection>
    </DesignCanvas>
  );
}

window.addEventListener('load', () => {
  const root = ReactDOM.createRoot(document.getElementById('root'));
  root.render(<App/>);
});
