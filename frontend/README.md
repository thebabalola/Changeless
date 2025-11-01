# Changeless Frontend

Frontend application for **Changeless** - a decentralized governance protocol designed to ensure transparent, community-driven decision-making and fund management.

## 🚀 Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn
- MetaMask or any Web3 wallet

### Installation

1. Install dependencies:

```bash
npm install
```

2. Create a `.env.local` file (if needed):

```env
NEXT_PUBLIC_PROJECT_ID=your_reown_project_id
NEXT_PUBLIC_CHAIN=sepolia
```

3. Run the development server:

```bash
npm run dev
```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

## 🛠️ Tech Stack

- **Framework**: Next.js 16 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS v4
- **Wallet Connection**: Reown AppKit (WalletConnect)
- **Blockchain Interaction**: Wagmi, Viem, Ethers.js
- **React Query**: TanStack Query

## 📦 Key Dependencies

- `next` - Next.js framework
- `react` & `react-dom` - React library
- `@reown/appkit` - Wallet connection via Reown/WalletConnect
- `wagmi` - React Hooks for Ethereum
- `viem` - TypeScript Ethereum library
- `@tanstack/react-query` - Data fetching and caching
- `ethers` - Ethereum JavaScript library
- `lucide-react` - Icon library

## 📁 Project Structure

```
frontend/
├── src/
│   ├── app/              # Next.js App Router pages
│   │   ├── layout.tsx    # Root layout with providers
│   │   └── page.tsx      # Landing page
│   ├── components/       # React components
│   │   ├── Navbar.tsx    # Navigation with wallet connection
│   │   └── Footer.tsx    # Footer component
│   ├── config/          # Configuration files
│   │   ├── wagmi.ts     # Wagmi configuration
│   │   └── adapter.ts   # Ethers.js adapter
│   └── context/         # Context providers
│       ├── appkit.tsx   # Reown AppKit setup
│       └── providers.tsx # React providers wrapper
└── public/              # Static assets
```

## 🎨 Features

- **Wallet Connection**: Integrated Reown/AppKit for seamless wallet connections
- **Landing Page**: Professional landing page with hero section, features, and CTA
- **Responsive Design**: Mobile-first responsive design with Tailwind CSS
- **TypeScript**: Full TypeScript support for type safety
- **Modern UI**: Gradient theme with professional design system

## 🔧 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

## 🌐 Network Support

Currently configured for:
- **Sepolia Testnet** (default)

To add more networks, update `src/config/wagmi.ts` and `src/context/appkit.tsx`.

## 📝 Wallet Connection

The app uses Reown AppKit for wallet connections, supporting:
- MetaMask
- WalletConnect
- Coinbase Wallet
- And many more wallets

## 🚀 Deployment

### Deploy to Vercel

The easiest way to deploy is using [Vercel](https://vercel.com):

```bash
npm run build
```

Then push to GitHub and connect to Vercel for automatic deployments.

## 🔗 Links

- [Next.js Documentation](https://nextjs.org/docs)
- [Reown AppKit Documentation](https://reown.com/docs)
- [Wagmi Documentation](https://wagmi.sh)

## 📄 License

MIT
