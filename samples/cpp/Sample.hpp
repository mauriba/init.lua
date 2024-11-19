#ifndef CPP_SAMPLE_HPP
#define CPP_SAMPLE_HPP

#include <iostream>

namespace cpp {

class Sample {
public:
    Sample(std::string test) {
        std::cout << "Sample instance constructed\n"; 
        std::cout << test << std::endl;
    }
    ~Sample() {
        std::cout << "Sample instance destructed\n";
    }
};

}

#endif
