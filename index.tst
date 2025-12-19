import React, { useState, useEffect, useMemo } from 'react';
import ReactDOM from 'react-dom/client';
import { 
  Settings, Menu, PlusCircle, Gift, Zap, ShieldCheck, ChevronRight, 
  Twitter, Instagram, Youtube, Send, MessageSquare, Monitor, Users, 
  Box, TrendingUp, Swords, Home, RotateCcw, Trophy, X, Check, HelpCircle, 
  ChevronDown, User, Hash, RefreshCw, FileText, BookOpen, CreditCard,
  Lock, Globe, ExternalLink
} from 'lucide-react';

// --- TYPES & DATA ---
enum Rarity {
  COMMON = 'COMMON',
  UNCOMMON = 'UNCOMMON',
  RARE = 'RARE',
  EPIC = 'EPIC',
  LEGENDARY = 'LEGENDARY',
  MYTHIC = 'MYTHIC'
}

const RARITY_COLORS: Record<string, string> = {
  [Rarity.COMMON]: '#94a3b8',
  [Rarity.UNCOMMON]: '#22c55e',
  [Rarity.RARE]: '#3b82f6',
  [Rarity.EPIC]: '#a855f7',
  [Rarity.LEGENDARY]: '#f97316',
  [Rarity.MYTHIC]: '#eab308'
};

const FORTNITE_ITEMS = [
  { id: 's1', name: 'Renegade Raider', rarity: Rarity.MYTHIC, image: 'https://fortnite-api.com/images/cosmetics/br/cid_028_athena_commando_f_retro/icon.png', price: 1500.00 },
  { id: 's2', name: 'Black Knight', rarity: Rarity.LEGENDARY, image: 'https://fortnite-api.com/images/cosmetics/br/cid_035_athena_commando_m_medieval/icon.png', price: 850.00 },
  { id: 's3', name: 'Galaxy', rarity: Rarity.MYTHIC, image: 'https://fortnite-api.com/images/cosmetics/br/cid_175_athena_commando_m_celestial/icon.png', price: 2500.00 },
  { id: 's4', name: 'Aura', rarity: Rarity.UNCOMMON, image: 'https://fortnite-api.com/images/cosmetics/br/cid_407_athena_commando_f_treasurehunterfashion/icon.png', price: 12.00 },
  { id: 's5', name: 'Midas', rarity: Rarity.LEGENDARY, image: 'https://fortnite-api.com/images/cosmetics/br/cid_694_athena_commando_m_goldenSkeleton/icon.png', price: 250.00 },
  { id: 's6', name: 'Skull Trooper', rarity: Rarity.EPIC, image: 'https://fortnite-api.com/images/cosmetics/br/cid_030_athena_commando_m_halloween/icon.png', price: 400.00 },
  { id: 's7', name: 'Travis Scott', rarity: Rarity.MYTHIC, image: 'https://fortnite-api.com/images/cosmetics/br/cid_733_athena_commando_m_cyclone/icon.png', price: 1200.00 },
  { id: 's8', name: 'Ikonik', rarity: Rarity.EPIC, image: 'https://fortnite-api.com/images/cosmetics/br/cid_371_athena_commando_m_kpop/icon.png', price: 900.00 },
  { id: 's9', name: 'Wildcat', rarity: Rarity.EPIC, image: 'https://fortnite-api.com/images/cosmetics/br/cid_889_athena_commando_f_skater_c/icon.png', price: 2000.00 },
  { id: 'p1', name: 'Candy Axe', rarity: Rarity.EPIC, image: 'https://fortnite-api.com/images/cosmetics/br/pickaxe_id_133_holidaycandy/icon.png', price: 150.00 },
  { id: 'p2', name: 'Star Wand', rarity: Rarity.RARE, image: 'https://fortnite-api.com/images/cosmetics/br/pickaxe_id_188_starwand/icon.png', price: 45.00 },
  { id: 'e1', name: 'Scenario', rarity: Rarity.RARE, image: 'https://fortnite-api.com/images/cosmetics/br/eid_kpop/icon.png', price: 45.00 },
];

const generateCases = (prefix: string, title: string, count: number) => {
  return Array.from({ length: count }).map((_, i) => ({
    id: `${prefix}-${i}`,
    name: `${title} ${i + 1}`,
    price: Math.floor(Math.random() * 200) + 1,
    image: FORTNITE_ITEMS[Math.floor(Math.random() * FORTNITE_ITEMS.length)].image,
    tag: i === 0 ? 'HOT' : undefined
  }));
};

const CASE_SECTIONS = [
  { title: 'OG LEGENDS', cases: generateCases('og', 'VAULT', 8) },
  { title: 'SWEATY SKINS', cases: generateCases('sw', 'SWEAT', 8) },
  { title: 'MYTHIC VAULT', cases: generateCases('mv', 'MYTHIC', 8) },
  { title: 'PICKAXE FRENZY', cases: generateCases('pf', 'AXE', 8) },
  { title: 'EMOTE PACKS', cases: generateCases('ep', 'DANCE', 8) },
  { title: 'GLIDER GALAXY', cases: generateCases('gg', 'GLIDE', 6) },
  { title: 'WRAP COLLECTION', cases: generateCases('wc', 'WRAP', 6) },
  { title: 'STARTER PACKS', cases: generateCases('sp', 'ROOKIE', 6) },
];

// --- TRANSLATIONS ---
const translations: Record<string, any> = {
  en: {
    getFree: "Get Free", giveaways: "Giveaways", skinChanger: "Skin Changer", upgrader: "Upgrader", caseBattle: "Case Battle",
    home: "Home", winterVault: "THE WINTER VAULT IS OPEN", mainCases: "MAIN CASES", dailyRewards: "DAILY REWARDS", verifiedFair: "VERIFIED FAIR",
    instantDelivery: "INSTANT DELIVERY", enterEvent: "ENTER TO THE EVENT", settingsTitle: "Settings", myAccount: "My Account", affiliate: "Affiliate System"
  },
  hi: {
    getFree: "मुफ्त पाएं", giveaways: "गिवअवे", skinChanger: "स्किन चेंजर", upgrader: "अपग्रेडर", caseBattle: "केस बैटल",
    home: "होम", winterVault: "विंटर वॉल्ट खुला है", mainCases: "मुख्य केस", dailyRewards: "दैनिक पुरस्कार", verifiedFair: "सत्यापित निष्पक्ष",
    instantDelivery: "तुरंत डिलीवरी", enterEvent: "इवेंट में प्रवेश करें", settingsTitle: "सेटिंग्स", myAccount: "मेरा खाता", affiliate: "एफिलिएट सिस्टम"
  }
};

// --- COMPONENTS ---

const Snowfall = () => {
  const snowflakes = useMemo(() => Array.from({ length: 40 }).map((_, i) => ({
    id: i, left: `${Math.random() * 100}%`, delay: `${Math.random() * 10}s`, duration: `${Math.random() * 10 + 10}s`, size: `${Math.random() * 10 + 10}px`, opacity: Math.random()
  })), []);
  return <>{snowflakes.map(s => <div key={s.id} className="snowflake" style={{ left: s.left, animationDelay: s.delay, animationDuration: s.duration, fontSize: s.size, opacity: s.opacity }}>❄</div>)}</>;
};

const Sidebar = ({ view, setView }: any) => {
  const menuItems = [
    { icon: Home, id: 'home' }, { icon: Swords, id: 'battles' }, { icon: TrendingUp, id: 'upgrader' }, { icon: RotateCcw, id: 'contracts' }, { icon: Trophy, id: 'leaderboard' }, { icon: Gift, id: 'free' }
  ];
  return (
    <aside className="hidden lg:flex flex-col w-[88px] h-[calc(100vh-80px)] bg-[#0d0d0f] border-r border-white/5 sticky top-20 py-8 items-center shrink-0">
      {menuItems.map(item => (
        <button key={item.id} onClick={() => setView(item.id)} className={`w-16 h-16 flex items-center justify-center rounded-[24px] mb-3 transition-all ${view === item.id ? 'bg-yellow-500/10 border border-yellow-500/40 text-yellow-500' : 'text-zinc-600 hover:text-white hover:bg-white/5'}`}>
          <item.icon size={26} />
        </button>
      ))}
      <div className="mt-auto flex flex-col items-center gap-4">
        <span className="text-[10px] font-black text-zinc-800 uppercase vertical-text tracking-widest">ONLINE</span>
        <div className="flex flex-col items-center gap-1">
          <div className="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse" />
          <span className="text-[11px] font-black text-zinc-500">4,281</span>
        </div>
      </div>
    </aside>
  );
};

const LiveDrops = () => {
  const [drops, setDrops] = useState<any[]>([]);
  useEffect(() => {
    const initial = Array.from({ length: 20 }).map((_, i) => ({ id: i, user: `P${Math.floor(Math.random() * 999)}`, item: FORTNITE_ITEMS[Math.floor(Math.random() * FORTNITE_ITEMS.length)] }));
    setDrops(initial);
    const interval = setInterval(() => setDrops(prev => [{ id: Date.now(), user: `P${Math.floor(Math.random() * 999)}`, item: FORTNITE_ITEMS[Math.floor(Math.random() * FORTNITE_ITEMS.length)] }, ...prev.slice(0, 19)]), 3000);
    return () => clearInterval(interval);
  }, []);
  return (
    <div className="h-28 bg-[#0a0a0c] border-b border-white/5 flex items-center overflow-hidden">
      <div className="flex gap-3 px-6 whitespace-nowrap overflow-x-auto no-scrollbar">
        {drops.map(d => (
          <div key={d.id} className="w-24 h-24 glass rounded-lg flex flex-col items-center justify-center p-2 group transition-transform hover:scale-105" style={{ borderBottom: `2px solid ${RARITY_COLORS[d.item.rarity]}` }}>
            <img src={d.item.image} className="w-12 h-12 object-contain" alt="drop" />
            <span className="text-[10px] text-zinc-600 mt-1 truncate w-full text-center">{d.user}</span>
          </div>
        ))}
      </div>
    </div>
  );
};

const NavigationMenu = ({ isOpen, onClose, setView }: any) => {
  if (!isOpen) return null;
  return (
    <div className="fixed inset-0 z-[200] bg-[#0d0d0f]/95 backdrop-blur-2xl p-12 overflow-y-auto animate-in fade-in">
      <div className="max-w-4xl mx-auto">
        <div className="flex justify-end mb-16"><button onClick={onClose} className="p-4 bg-zinc-900 rounded-2xl"><X size={32}/></button></div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-16">
          <section><h3 className="text-zinc-600 font-bold text-xs uppercase tracking-widest mb-8">ACCOUNT</h3><div className="space-y-4">{['ACCOUNT', 'AFFILIATE', 'PROMO'].map(l => <button key={l} onClick={() => {setView(l.toLowerCase()); onClose();}} className="w-full text-left p-5 bg-zinc-900 rounded-2xl hover:bg-zinc-800 font-bold uppercase text-sm">{l}</button>)}</div></section>
          <section className="md:col-span-2"><h3 className="text-zinc-600 font-bold text-xs uppercase tracking-widest mb-8">GAMES</h3><div className="grid grid-cols-2 gap-4">{['BATTLES', 'UPGRADER', 'CHANGER', 'CONTRACTS', 'GIVEAWAYS'].map(g => <button key={g} onClick={() => {setView(g.toLowerCase()); onClose();}} className="p-8 bg-zinc-900 rounded-3xl hover:bg-zinc-800 font-black text-xl italic uppercase">{g}</button>)}</div></section>
        </div>
      </div>
    </div>
  );
};

const Hero = ({ currentLang }: any) => {
  const t = translations[currentLang] || translations.en;
  return (
    <div className="px-8 pt-8">
      <div className="relative h-[540px] rounded-[52px] overflow-hidden bg-[#141416] border border-white/5 flex items-center">
        <img src="https://i.ibb.co/rR9LrXYH/Chat-GPT-Image-Dec-19-2025-07-04-05-PM.png" className="absolute inset-0 w-full h-full object-cover brightness-[0.4] scale-105" alt="hero" />
        <div className="relative z-10 px-16 max-w-4xl">
          <div className="bg-red-600 text-white px-5 py-2 rounded-full text-[10px] font-black uppercase tracking-widest mb-6 inline-block">Christmas Special</div>
          <h1 className="text-[100px] font-gaming font-black italic text-white leading-[0.85] uppercase tracking-tighter mb-8">
            {t.winterVault.split(' ')[0]} <br /><span className="text-red-500 text-glow-red">{t.winterVault.split(' ').slice(1).join(' ')}</span>
          </h1>
          <button className="bg-red-600 hover:bg-red-500 text-white px-16 py-6 rounded-[32px] font-black text-sm uppercase transition-all flex items-center gap-3 shadow-2xl shadow-red-500/20">
            {t.enterEvent} <ChevronRight size={20}/>
          </button>
        </div>
        <img src="https://fortnite-api.com/images/cosmetics/br/cid_301_athena_commando_m_santa/featured.png" className="absolute right-0 bottom-0 h-[110%] object-contain animate-float pointer-events-none" alt="santa" />
      </div>
    </div>
  );
};

const EventBanner = () => {
  const events = [
    { name: 'SANTAS BAG', price: 1.0, img: 'https://fortnite-api.com/images/cosmetics/br/cid_301_athena_commando_m_santa/featured.png' },
    { name: 'FROSTBITE', price: 5.0, img: 'https://fortnite-api.com/images/cosmetics/br/cid_285_athena_commando_m_arcticice/featured.png' },
    { name: 'BLIZZARD', price: 20.0, img: 'https://fortnite-api.com/images/cosmetics/br/cid_984_athena_commando_f_snowfall_6f8g2/featured.png' },
    { name: 'NORTH POLE', price: 60.0, img: 'https://fortnite-api.com/images/cosmetics/br/cid_294_athena_commando_f_banditwinter/featured.png' },
    { name: 'LEGACY WINTER', price: 250.0, img: 'https://fortnite-api.com/images/cosmetics/br/cid_010_athena_commando_m_snow_01/featured.png' },
  ];
  return (
    <div className="px-8 mt-16">
      <h2 className="text-2xl font-gaming font-black italic uppercase mb-8">EVENT CASES <span className="text-zinc-600 ml-4 font-inter font-medium not-italic">- 17 DAYS LEFT</span></h2>
      <div className="grid grid-cols-2 md:grid-cols-5 gap-6">
        {events.map((e, i) => (
          <div key={i} className="group relative aspect-[4/5] rounded-[32px] overflow-hidden bg-[#141416] border border-white/5 hover:scale-[1.05] transition-transform cursor-pointer">
            <img src={e.img} className="absolute inset-0 w-full h-full object-cover brightness-50 group-hover:brightness-90 transition-all" alt={e.name} />
            <div className="absolute inset-0 bg-gradient-to-t from-black p-6 flex flex-col justify-end">
              <span className="bg-yellow-500 text-black w-fit px-3 py-1 rounded-lg font-black text-[10px] mb-2">${e.price.toFixed(2)}</span>
              <h4 className="font-gaming font-black text-white italic uppercase">{e.name}</h4>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

const CaseGrid = ({ currentLang }: any) => {
  const t = translations[currentLang] || translations.en;
  return (
    <div className="px-8 pb-32 mt-24 space-y-24">
      <h2 className="text-4xl font-gaming font-black italic uppercase">{t.mainCases}</h2>
      {CASE_SECTIONS.map((section, idx) => (
        <section key={idx}>
          <div className="flex items-center gap-4 mb-10"><h3 className="text-2xl font-gaming font-black italic uppercase text-white">{section.title}</h3><div className="h-px flex-1 bg-white/5" /></div>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8 gap-6">
            {section.cases.map(c => (
              <div key={c.id} className="group cursor-pointer bg-[#141416]/40 border border-white/5 rounded-[32px] p-6 flex flex-col items-center hover:bg-[#1a1a1e] transition-all relative">
                {c.tag && <span className="absolute top-4 left-4 bg-yellow-500 text-black text-[9px] font-black px-2 py-0.5 rounded uppercase">{c.tag}</span>}
                <div className="w-full aspect-square mb-6"><img src={c.image} className="w-full h-full object-contain group-hover:scale-110 transition-transform" alt={c.name} /></div>
                <h3 className="font-gaming text-lg font-black italic text-white mb-3 text-center uppercase truncate w-full">{c.name}</h3>
                <div className="bg-zinc-900 group-hover:bg-yellow-500 group-hover:text-black px-5 py-2 rounded-xl transition-all"><span className="text-sm font-black">${c.price.toFixed(2)}</span></div>
              </div>
            ))}
          </div>
        </section>
      ))}
    </div>
  );
};

const App = () => {
  const [view, setView] = useState('home');
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [lang, setLang] = useState('en');
  const [stats, setStats] = useState({ online: 6807, users: 13737728, cases: 546998827, upgrades: 166007649, battles: 51335488 });

  useEffect(() => {
    const t = setInterval(() => setStats(p => ({
      online: p.online + (Math.random() > 0.5 ? 1 : -1) * Math.floor(Math.random() * 3),
      users: p.users + (Math.random() > 0.8 ? 1 : 0),
      cases: p.cases + Math.floor(Math.random() * 3),
      upgrades: p.upgrades + Math.floor(Math.random() * 2),
      battles: p.battles + (Math.random() > 0.7 ? 1 : 0)
    })), 3000);
    return () => clearInterval(t);
  }, []);

  const f = (n: number) => n.toLocaleString('en-US').replace(/,/g, ' ');

  return (
    <div className="min-h-screen bg-[#0d0d0f] flex flex-col">
      <Snowfall />
      <NavigationMenu isOpen={isMenuOpen} onClose={() => setIsMenuOpen(false)} setView={setView} />
      
      <nav className="sticky top-0 z-[100] h-20 bg-[#0d0d0f]/95 backdrop-blur-xl border-b border-white/5 flex items-center justify-between px-8">
        <div className="flex items-center gap-10">
          <button onClick={() => setView('home')} className="flex items-center gap-2 group">
            <img src="https://i.ibb.co/d4HMs3Bm/image.png" className="h-10 transition-transform group-hover:scale-110" alt="logo" />
            <span className="font-gaming text-3xl font-black italic text-white uppercase tracking-tighter">R2G</span>
          </button>
          <div className="hidden lg:flex items-center gap-8 text-[11px] font-black uppercase tracking-widest text-zinc-500">
            {['battles', 'upgrader', 'free'].map(l => <button key={l} onClick={() => setView(l)} className="hover:text-white uppercase transition-colors">{l}</button>)}
          </div>
        </div>
        <div className="flex items-center gap-4">
          {isLoggedIn ? (
            <div className="flex items-center gap-3">
              <div className="bg-zinc-900 border border-white/5 rounded-2xl pl-5 pr-1 py-1 flex items-center gap-3"><span className="text-sm font-black text-yellow-500">$1,452.20</span><button className="bg-yellow-500 p-2 rounded-xl text-black"><PlusCircle size={18}/></button></div>
              <div className="w-11 h-11 bg-zinc-800 rounded-2xl border border-white/5"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Lucky" className="rounded-[14px]" alt="pfp" /></div>
            </div>
          ) : (
            <button onClick={() => setIsLoggedIn(true)} className="flex items-center gap-2 bg-green-500/10 border border-green-500/30 text-green-500 px-6 py-2.5 rounded-2xl text-xs font-black uppercase">
              <img src="https://www.google.com/favicon.ico" className="w-4 h-4" alt="g" />Sign In
            </button>
          )}
          <button onClick={() => setLang(lang === 'en' ? 'hi' : 'en')} className="p-3 bg-zinc-900 rounded-2xl border border-white/5 text-zinc-400 uppercase font-black text-[10px]">{lang}</button>
          <button onClick={() => setIsMenuOpen(true)} className="p-3 bg-zinc-900 rounded-2xl border border-white/5 text-zinc-400 hover:text-white transition-all"><Menu size={20}/></button>
        </div>
      </nav>

      <LiveDrops />

      <div className="flex flex-1 relative">
        <Sidebar view={view} setView={setView} />
        <main className="flex-1">
          {view === 'home' ? (
            <>
              <Hero currentLang={lang} />
              <EventBanner />
              <CaseGrid currentLang={lang} />
            </>
          ) : (
            <div className="h-[70vh] flex flex-col items-center justify-center p-20">
               <div className="bg-[#141416] p-16 rounded-[48px] border border-white/5 text-center shadow-2xl">
                 <h2 className="text-6xl font-gaming font-black italic uppercase text-white mb-6 tracking-tighter">{view}</h2>
                 <p className="text-zinc-500 text-xl font-medium mb-10">This feature is currently being optimized for the ultimate experience.</p>
                 <button onClick={() => setView('home')} className="bg-red-600 text-white px-12 py-5 rounded-2xl font-black uppercase">Back to Home</button>
               </div>
            </div>
          )}

          {/* Stats Section */}
          <div className="w-full border-y border-white/5 py-16 bg-[#0d0d0f]">
            <div className="max-w-[1400px] mx-auto px-8 grid grid-cols-2 md:grid-cols-5 gap-12 text-center">
              {[
                { l: 'Online', v: stats.online, c: 'text-green-500', i: Monitor },
                { l: 'Registered Users', v: stats.users, c: 'text-blue-500', i: Users },
                { l: 'Opened Cases', v: stats.cases, c: 'text-yellow-500', i: Box },
                { l: 'Upgrades', v: stats.upgrades, c: 'text-purple-500', i: TrendingUp },
                { l: 'Case Battles', v: stats.battles, c: 'text-red-500', i: Swords },
              ].map((s, idx) => (
                <div key={idx} className="flex flex-col items-center">
                  <div className={`${s.c} mb-4 p-4 bg-white/5 rounded-2xl`}><s.i size={24} /></div>
                  <span className="text-[10px] text-zinc-600 font-black uppercase tracking-[0.2em] mb-1">{s.l}</span>
                  <span className="text-3xl font-gaming font-black italic tabular-nums">{f(s.v)}</span>
                </div>
              ))}
            </div>
          </div>

          {/* KOBADA FOOTER (BIG FOOTER) */}
          <footer className="bg-[#0a0a0c] border-t border-white/5 pt-24 pb-12">
            <div className="max-w-[1400px] mx-auto px-8">
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-16 mb-24">
                <div className="lg:col-span-4">
                  <div className="flex items-center gap-4 mb-8">
                    <img src="https://i.ibb.co/d4HMs3Bm/image.png" className="h-14" alt="logo" />
                    <span className="font-gaming text-5xl font-black italic uppercase tracking-tighter">R2G</span>
                  </div>
                  <p className="text-zinc-500 text-base leading-relaxed mb-10">
                    R2G is the world's most trusted Fortnite item marketplace. Secure case openings, rare collectibles, and a transparent gaming environment.
                  </p>
                  <div className="flex gap-4">
                    {[Twitter, Instagram, Youtube, Send, MessageSquare].map((Ic, i) => (
                      <button key={i} className="w-12 h-12 flex items-center justify-center bg-white/5 rounded-xl text-zinc-400 hover:text-white hover:bg-white/10 transition-all"><Ic size={20} /></button>
                    ))}
                  </div>
                </div>
                <div className="lg:col-span-8 grid grid-cols-2 sm:grid-cols-4 gap-12">
                  {[
                    { title: 'Information', links: ['About Us', 'Contact', 'Blog', 'Affiliate', 'News'] },
                    { title: 'Legal', links: ['Privacy Policy', 'Terms of Service', 'AML Policy', 'Cookie Policy'] },
                    { title: 'Support', links: ['Help Center', 'Partners', 'Promos', 'FAQ', 'Bounty'] },
                    { title: 'Trust', links: ['Fair Play', 'Security', 'GDPR', 'Wallet Safety'] }
                  ].map((col, idx) => (
                    <div key={idx}>
                      <h4 className="text-[11px] font-black text-zinc-600 mb-8 uppercase tracking-[0.3em]">{col.title}</h4>
                      <ul className="space-y-4">{col.links.map(l => <li key={l}><button className="text-zinc-500 hover:text-red-500 text-sm font-bold uppercase transition-all tracking-wide">{l}</button></li>)}</ul>
                    </div>
                  ))}
                </div>
              </div>
              
              <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-24">
                <div className="flex items-center gap-6 p-8 bg-white/5 rounded-[32px] border border-white/5"><ShieldCheck className="text-green-500 w-12 h-12" /><div><h4 className="font-gaming font-black text-xl italic uppercase">Provably Fair</h4><p className="text-xs text-zinc-500 uppercase tracking-widest">Verified</p></div></div>
                <div className="flex items-center gap-6 p-8 bg-white/5 rounded-[32px] border border-white/5"><Lock className="text-blue-500 w-12 h-12" /><div><h4 className="font-gaming font-black text-xl italic uppercase">SSL Secured</h4><p className="text-xs text-zinc-500 uppercase tracking-widest">Safe Payments</p></div></div>
                <div className="flex items-center gap-6 p-8 bg-white/5 rounded-[32px] border border-white/5"><Globe className="text-purple-500 w-12 h-12" /><div><h4 className="font-gaming font-black text-xl italic uppercase">Global Node</h4><p className="text-xs text-zinc-500 uppercase tracking-widest">Fast</p></div></div>
              </div>

              <div className="flex flex-wrap items-center justify-center gap-12 mb-24 opacity-20 grayscale hover:opacity-100 hover:grayscale-0 transition-all duration-700">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png" className="h-4" alt="visa" />
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png" className="h-8" alt="mc" />
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/PayPal.svg/1200px-PayPal.svg.png" className="h-5" alt="pp" />
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png" className="h-6" alt="btc" />
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Ethereum_logo.svg/1200px-Ethereum_logo.svg.png" className="h-6" alt="eth" />
              </div>

              <div className="border-t border-white/5 pt-12 flex flex-col lg:flex-row justify-between items-center gap-8">
                <div className="text-center lg:text-left">
                  <p className="text-zinc-600 text-[10px] uppercase font-bold tracking-widest mb-4">© 2025 R2G Skins. All rights reserved.</p>
                  <p className="text-zinc-800 text-[9px] uppercase font-black leading-relaxed max-w-2xl">Not affiliated with Epic Games, Inc. Fortnite is a trademark of Epic Games, Inc. Play responsibly.</p>
                </div>
                <div className="flex gap-8 text-[10px] font-black text-zinc-500 uppercase tracking-widest">
                  <button className="hover:text-white">Cookies</button><button className="hover:text-white">Privacy</button><button className="hover:text-white flex items-center gap-1">Licenses <ExternalLink size={10} /></button>
                </div>
              </div>
            </div>
          </footer>
        </main>
      </div>
    </div>
  );
};

const root = ReactDOM.createRoot(document.getElementById('root')!);
root.render(<App />);
