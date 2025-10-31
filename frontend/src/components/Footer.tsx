"use client";

import Link from "next/link";
import { Github, Twitter, Linkedin, Mail } from "lucide-react";

export function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-gradient-to-r from-slate-900 via-purple-900 to-slate-900 border-t border-purple-500/20 mt-auto">
      <div className="max-w-7xl mx-auto px-6 md:px-12 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Brand Section */}
          <div className="col-span-1 md:col-span-2">
            <div className="flex items-center gap-2 mb-4">
              <span className="text-3xl">🛡️</span>
              <span className="bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent text-2xl font-bold">
                Changeless
              </span>
            </div>
            <p className="text-gray-300 mb-4 max-w-md">
              A decentralized governance protocol designed to ensure transparent, community-driven decision-making and fund management.
            </p>
            <div className="flex gap-4 mt-6">
              <a
                href="https://github.com"
                target="_blank"
                rel="noopener noreferrer"
                className="text-gray-400 hover:text-[#3B82F6] transition-colors"
                aria-label="GitHub"
              >
                <Github className="w-6 h-6" />
              </a>
              <a
                href="https://twitter.com"
                target="_blank"
                rel="noopener noreferrer"
                className="text-gray-400 hover:text-[#3B82F6] transition-colors"
                aria-label="Twitter"
              >
                <Twitter className="w-6 h-6" />
              </a>
              <a
                href="https://linkedin.com"
                target="_blank"
                rel="noopener noreferrer"
                className="text-gray-400 hover:text-[#3B82F6] transition-colors"
                aria-label="LinkedIn"
              >
                <Linkedin className="w-6 h-6" />
              </a>
              <a
                href="mailto:contact@changeless.app"
                className="text-gray-400 hover:text-[#3B82F6] transition-colors"
                aria-label="Email"
              >
                <Mail className="w-6 h-6" />
              </a>
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="text-white font-semibold mb-4">Quick Links</h3>
            <ul className="space-y-2">
              <li>
                <Link
                  href="/"
                  className="text-gray-300 hover:text-[#3B82F6] transition-colors"
                >
                  Home
                </Link>
              </li>
              <li>
                <Link
                  href="/proposals"
                  className="text-gray-300 hover:text-[#3B82F6] transition-colors"
                >
                  Proposals
                </Link>
              </li>
              <li>
                <Link
                  href="/treasury"
                  className="text-gray-300 hover:text-[#3B82F6] transition-colors"
                >
                  Treasury
                </Link>
              </li>
            </ul>
          </div>

          {/* Resources */}
          <div>
            <h3 className="text-white font-semibold mb-4">Resources</h3>
            <ul className="space-y-2">
              <li>
                <a
                  href="/docs"
                  className="text-gray-300 hover:text-[#3B82F6] transition-colors"
                >
                  Documentation
                </a>
              </li>
              <li>
                <a
                  href="/whitepaper"
                  className="text-gray-300 hover:text-[#3B82F6] transition-colors"
                >
                  Whitepaper
                </a>
              </li>
              <li>
                <a
                  href="/faq"
                  className="text-gray-300 hover:text-[#3B82F6] transition-colors"
                >
                  FAQ
                </a>
              </li>
            </ul>
          </div>
        </div>

        <div className="border-t border-purple-500/20 mt-8 pt-8 text-center">
          <p className="text-gray-400 text-sm">
            © {currentYear} Changeless. All rights reserved.
          </p>
          <p className="text-gray-500 text-xs mt-2">
            Built with transparency, powered by blockchain.
          </p>
        </div>
      </div>
    </footer>
  );
}

