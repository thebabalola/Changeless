import Link from "next/link";
import { Navbar } from "@/components/Navbar";
import { Footer } from "@/components/Footer";
import { Shield, Users, Vote, Lock, TrendingUp, Zap } from "lucide-react";

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-b from-slate-950 via-purple-950 to-slate-950">
      <Navbar />

      <main className="flex-1">
        {/* Hero Section */}
        <section className="relative overflow-hidden pt-20 pb-32 px-6 md:px-12">
          <div className="max-w-7xl mx-auto">
            <div className="text-center max-w-4xl mx-auto">
              <div className="inline-flex items-center gap-2 px-4 py-2 bg-purple-500/10 border border-purple-500/20 rounded-full mb-8">
                <Shield className="w-4 h-4 text-purple-400" />
                <span className="text-purple-300 text-sm font-medium">
                  Decentralized Governance Protocol
                </span>
              </div>
              
              <h1 className="text-5xl md:text-7xl font-bold mb-6 bg-gradient-to-r from-blue-400 via-purple-400 to-blue-400 bg-clip-text text-transparent leading-tight">
                Changeless
          </h1>
              
              <p className="text-xl md:text-2xl text-gray-300 mb-8 leading-relaxed">
                Empower your community with transparent, secure, and decentralized decision-making. 
                Built for trust, designed for governance.
              </p>
              
              <p className="text-lg text-gray-400 mb-12 max-w-2xl mx-auto">
                A decentralized governance protocol designed to ensure transparent, community-driven 
                decision-making and fund management. Built with Solidity, it empowers members to 
                propose, vote, and execute treasury actions securely—removing the need for centralized control.
              </p>

              <div className="flex flex-col sm:flex-row gap-4 justify-center">
                <Link
                  href="/proposals"
                  className="bg-gradient-to-r from-blue-500 to-purple-500 hover:from-blue-600 hover:to-purple-600 text-white px-8 py-4 rounded-lg text-lg font-semibold transition-all shadow-lg shadow-blue-500/50 hover:shadow-blue-500/70"
                >
                  Explore Proposals
                </Link>
                <Link
                  href="/treasury"
                  className="bg-slate-800/50 hover:bg-slate-700/50 border border-purple-500/30 text-white px-8 py-4 rounded-lg text-lg font-semibold transition-all"
                >
                  View Treasury
                </Link>
              </div>
            </div>
          </div>

          {/* Background decoration */}
          <div className="absolute inset-0 -z-10 overflow-hidden">
            <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-blue-500/10 rounded-full blur-3xl"></div>
            <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-purple-500/10 rounded-full blur-3xl"></div>
          </div>
        </section>

        {/* Features Section */}
        <section className="py-20 px-6 md:px-12 bg-slate-900/50">
          <div className="max-w-7xl mx-auto">
            <div className="text-center mb-16">
              <h2 className="text-4xl md:text-5xl font-bold mb-4 bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
                Key Features
              </h2>
              <p className="text-gray-400 text-lg max-w-2xl mx-auto">
                Everything you need for transparent, community-driven governance
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {/* Feature 1 */}
              <div className="bg-slate-800/50 border border-purple-500/20 rounded-xl p-8 hover:border-purple-500/40 transition-all">
                <div className="w-12 h-12 bg-purple-500/10 rounded-lg flex items-center justify-center mb-6">
                  <Vote className="w-6 h-6 text-purple-400" />
                </div>
                <h3 className="text-xl font-semibold text-white mb-3">
                  Proposal & Voting
                </h3>
                <p className="text-gray-400">
                  Create proposals and participate in community voting. Every decision is recorded on-chain for transparency.
                </p>
              </div>

              {/* Feature 2 */}
              <div className="bg-slate-800/50 border border-purple-500/20 rounded-xl p-8 hover:border-purple-500/40 transition-all">
                <div className="w-12 h-12 bg-blue-500/10 rounded-lg flex items-center justify-center mb-6">
                  <Lock className="w-6 h-6 text-blue-400" />
                </div>
                <h3 className="text-xl font-semibold text-white mb-3">
                  Secure Treasury
                </h3>
                <p className="text-gray-400">
                  Manage community funds securely with multi-signature controls and transparent transaction history.
                </p>
              </div>

              {/* Feature 3 */}
              <div className="bg-slate-800/50 border border-purple-500/20 rounded-xl p-8 hover:border-purple-500/40 transition-all">
                <div className="w-12 h-12 bg-purple-500/10 rounded-lg flex items-center justify-center mb-6">
                  <Users className="w-6 h-6 text-purple-400" />
                </div>
                <h3 className="text-xl font-semibold text-white mb-3">
                  Community-Driven
                </h3>
                <p className="text-gray-400">
                  No centralized control. Every member has a voice in shaping the future of the protocol.
                </p>
              </div>

              {/* Feature 4 */}
              <div className="bg-slate-800/50 border border-purple-500/20 rounded-xl p-8 hover:border-purple-500/40 transition-all">
                <div className="w-12 h-12 bg-blue-500/10 rounded-lg flex items-center justify-center mb-6">
                  <Shield className="w-6 h-6 text-blue-400" />
                </div>
                <h3 className="text-xl font-semibold text-white mb-3">
                  Transparent
                </h3>
                <p className="text-gray-400">
                  All governance actions are publicly verifiable on the blockchain. Trust through transparency.
                </p>
              </div>

              {/* Feature 5 */}
              <div className="bg-slate-800/50 border border-purple-500/20 rounded-xl p-8 hover:border-purple-500/40 transition-all">
                <div className="w-12 h-12 bg-purple-500/10 rounded-lg flex items-center justify-center mb-6">
                  <TrendingUp className="w-6 h-6 text-purple-400" />
                </div>
                <h3 className="text-xl font-semibold text-white mb-3">
                  Decentralized
                </h3>
                <p className="text-gray-400">
                  Built on blockchain technology, ensuring no single point of failure or control.
                </p>
              </div>

              {/* Feature 6 */}
              <div className="bg-slate-800/50 border border-purple-500/20 rounded-xl p-8 hover:border-purple-500/40 transition-all">
                <div className="w-12 h-12 bg-blue-500/10 rounded-lg flex items-center justify-center mb-6">
                  <Zap className="w-6 h-6 text-blue-400" />
                </div>
                <h3 className="text-xl font-semibold text-white mb-3">
                  Efficient Execution
                </h3>
                <p className="text-gray-400">
                  Execute approved proposals automatically through smart contracts, reducing delays and intermediaries.
          </p>
        </div>
            </div>
          </div>
        </section>

        {/* CTA Section */}
        <section className="py-20 px-6 md:px-12">
          <div className="max-w-4xl mx-auto text-center">
            <div className="bg-gradient-to-r from-blue-500/10 via-purple-500/10 to-blue-500/10 border border-purple-500/20 rounded-2xl p-12">
              <h2 className="text-3xl md:text-4xl font-bold mb-4 bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
                Ready to Get Started?
              </h2>
              <p className="text-gray-300 text-lg mb-8">
                Join the Changeless community and start participating in decentralized governance today.
              </p>
              <div className="flex flex-col sm:flex-row gap-4 justify-center">
                <Link
                  href="/proposals"
                  className="bg-gradient-to-r from-blue-500 to-purple-500 hover:from-blue-600 hover:to-purple-600 text-white px-8 py-4 rounded-lg text-lg font-semibold transition-all shadow-lg shadow-blue-500/50 hover:shadow-blue-500/70"
                >
                  View Active Proposals
                </Link>
                <Link
                  href="/treasury"
                  className="bg-slate-800/50 hover:bg-slate-700/50 border border-purple-500/30 text-white px-8 py-4 rounded-lg text-lg font-semibold transition-all"
                >
                  Explore Treasury
                </Link>
              </div>
            </div>
        </div>
        </section>
      </main>

      <Footer />
    </div>
  );
}
