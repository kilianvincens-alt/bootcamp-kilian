// Minty logo variants — each renders into a DCArtboard.
// Static markup, edit values inline; no shared style names (avoids globals).

function Logo01(){
  return (
    <div className="lg lg--cream">
      <div className="l01-wrap">
        <div className="l01-frame">
          <div className="word l01-word">Minty</div>
          <div className="l01-dot"></div>
        </div>
        <div className="l01-tag mono">
          <span>Sell</span><i></i><span>Buy</span><i></i><span>Trade</span>
        </div>
      </div>
    </div>
  );
}

function Logo02(){
  return (
    <div className="lg lg--cream">
      <div className="l02">
        <div className="l02-pip">MINT 10</div>
        <div className="l02-num">★</div>
        <div className="word l02-word">Minty<span style={{color:'#0b1410'}}>.</span></div>
        <div className="l02-foot">MARKETPLACE · EST 2026</div>
      </div>
    </div>
  );
}

function Logo03(){
  return (
    <div className="lg lg--mint">
      <div className="l03">Minty<span className="dot">.</span></div>
    </div>
  );
}

function Logo04(){
  return (
    <div className="lg lg--paper">
      <div className="l04-wrap">
        <div className="l04-mark">
          <div className="l04-card c1"></div>
          <div className="l04-card c3"></div>
          <div className="l04-card c2"></div>
        </div>
        <div className="word l04-word">Minty<span className="l04-dot">.</span></div>
      </div>
    </div>
  );
}

function Logo05(){
  // generic round seal — vocabulary, not anyone's specific badge
  const ticks = Array.from({length:60});
  return (
    <div className="lg lg--cream">
      <div className="l05">
        <svg className="l05-arc" viewBox="0 0 240 240" aria-hidden="true">
          <defs>
            <path id="l05curve" d="M 120,120 m -94,0 a 94,94 0 1,1 188,0 a 94,94 0 1,1 -188,0"/>
          </defs>
          <text fill="#0b1410" style={{fontFamily:'JetBrains Mono',fontSize:11,letterSpacing:'.22em',fontWeight:600}}>
            <textPath href="#l05curve" startOffset="0">
              · MINTY MARKETPLACE · AUTHENTIC TRADES · MINT CONDITION · SINCE 2026 ·
            </textPath>
          </text>
        </svg>
        <div className="l05-inner">
          <div className="l05-M">M</div>
          <div className="l05-grade">GRADE · 10</div>
        </div>
      </div>
    </div>
  );
}

function Logo06(){
  return (
    <div className="lg lg--ink">
      <div className="word l06">Minty<span className="dot">.</span></div>
    </div>
  );
}

function Logo07(){
  return (
    <div className="lg lg--cream">
      <div className="word l07-word">
        Minty<span className="l07-pip"></span>
      </div>
    </div>
  );
}

function Logo08(){
  return (
    <div className="lg lg--paper">
      <div className="l08">
        <div className="word w">Minty<span className="dot">.</span></div>
        <div className="rule"></div>
        <div className="mono tag">Sell · Buy · Trade</div>
      </div>
    </div>
  );
}

function Logo09(){
  return (
    <div className="lg lg--cream">
      <div className="l09">
        <div className="word m">M</div>
        <div className="d"></div>
      </div>
    </div>
  );
}

function Logo10(){
  return (
    <div className="lg lg--paper">
      <div className="l10">
        <div className="ring"></div>
        <div className="word m">M.</div>
      </div>
    </div>
  );
}

function Logo11(){
  return (
    <div className="lg lg--cream">
      <div className="l11-card">
        <div className="l11-art">[ CARD ARTWORK ]</div>
        <div className="l11-name">Charizard · Holo</div>
        <div className="l11-meta">EDITION · 1ST · 1999<br/>VERIFIED BY MINTY</div>
        <div className="l11-stamp">
          <div className="m">M.</div>
          <div className="g">MINT · 10</div>
        </div>
      </div>
    </div>
  );
}

Object.assign(window, { Logo01, Logo02, Logo03, Logo04, Logo05, Logo06, Logo07, Logo08, Logo09, Logo10, Logo11 });
